### Variables

locals {
  cluster_name                 = "cluster_name"                 # Replace with your EKS cluster name
  bucket_name                  = "basalt-files"                 # The bucket name should be used in `storage.bucket` in the Helm chart
  private_bucket_name          = "basalt-files-private"         # The bucket name should be used in `storage.privateBucket` in the Helm chart
  otel_bucket_name             = "basalt-otel-traces"           # The bucket name should be used in `storage.otelBucket` in the Helm chart
  otel_sqs_queue_name          = "basalt-otel-traces-ingestion" # The SQS queue name should be used in `otelSqsProcessor.sqsQueueUrl` in the Helm chart
  script_evaluator_lambda_name = "ScriptEvaluator"              # The Lambda function name for script evaluation
}

### Common Buckets

resource "aws_s3_bucket" "public_files" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket" "private_uploads" {
  bucket = local.private_bucket_name
}

### Otel Traces Buckets and SQS

resource "aws_s3_bucket" "otel_traces" {
  bucket = local.otel_bucket_name
}

resource "aws_sqs_queue" "otel_traces_ingestion" {
  name                       = local.otel_sqs_queue_name
  visibility_timeout_seconds = 300 # 5 minutes for Lambda processing
}

# SQS Queue Policy to allow S3 to send messages to the SQS queue
resource "aws_sqs_queue_policy" "s3_to_sqs" {
  queue_url = aws_sqs_queue.otel_traces_ingestion.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3ToSendMessages"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.otel_traces_ingestion.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_s3_bucket.otel_traces.arn
          }
        }
      }
    ]
  })
}

# Set up S3 to SQS notification for OTEL traces bucket
resource "aws_s3_bucket_notification" "otel_traces_bucket" {
  bucket = aws_s3_bucket.otel_traces.id

  queue {
    queue_arn = aws_sqs_queue.otel_traces_ingestion.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_sqs_queue.otel_traces_ingestion, aws_sqs_queue_policy.s3_to_sqs]
}

### Lambda for evaluator

resource "aws_cloudwatch_log_group" "script_evaluator" {
  name = "/aws/lambda/${local.script_evaluator_lambda_name}"
}

resource "aws_iam_role" "script_evaluator" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy" "script_evaluator" {
  role = aws_iam_role.script_evaluator.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "${aws_cloudwatch_log_group.script_evaluator.arn}:*"
      },
    ]
  })
}

data "archive_file" "script_evaluator" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py" # Ask Basalt to get this file
  output_path = "/tmp/function.zip"
}

resource "aws_lambda_function" "script_evaluator" {
  function_name = local.script_evaluator_lambda_name
  role          = aws_iam_role.script_evaluator.arn

  filename = data.archive_file.script_evaluator.output_path
  handler  = "lambda_function.lambda_handler"
  runtime  = "python3.13"

  timeout = 60

  logging_config {
    log_group  = aws_cloudwatch_log_group.script_evaluator.name
    log_format = "Text"
  }
}

### Policies for each service account

resource "aws_iam_policy" "buckets_access" {
  name = "Basalt API EKS Service Account Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.public_files.arn}",
          "${aws_s3_bucket.public_files.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.private_uploads.arn}",
          "${aws_s3_bucket.private_uploads.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "script_evaluator" {
  name = "Basalt Script Evaluator Lambda Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : [
          aws_lambda_function.script_evaluator.arn
        ]
      },
    ]
  })
}

resource "aws_iam_policy" "otel_processor" {
  name = "Basalt OTEL processor EKS Service Account Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ]
        Resource = [
          "${aws_sqs_queue.otel_traces_ingestion.arn}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.otel_traces.arn}",
          "${aws_s3_bucket.otel_traces.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "otel_collector" {
  name = "Basalt OTEL collector EKS Service Account Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.otel_traces.arn}",
          "${aws_s3_bucket.otel_traces.arn}/*"
        ]
      }
    ]
  })
}

module "api_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.7.0"

  name = "pod-identity-basalt-api"

  additional_policy_arns = {
    buckets          = aws_iam_policy.buckets_access.arn,
    script_evaluator = aws_iam_policy.script_evaluator.arn
  }

  association_defaults = {
    namespace       = "basalt"
    service_account = "basalt-api"
  }

  associations = {
    eks = {
      cluster_name = local.cluster_name
    }
  }
}

module "api_public_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.7.0"

  name = "pod-identity-basalt-public-api"
  additional_policy_arns = {
    custom = aws_iam_policy.buckets_access.arn
  }

  association_defaults = {
    namespace       = "basalt"
    service_account = "basalt-public-api"
  }

  associations = {
    eks = {
      cluster_name = local.cluster_name
    }
  }
}

module "jobs_runner_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.7.0"

  name = "pod-identity-basalt-jobs-runner"
  additional_policy_arns = {
    buckets          = aws_iam_policy.buckets_access.arn,
    script_evaluator = aws_iam_policy.script_evaluator.arn
  }

  association_defaults = {
    namespace       = "basalt"
    service_account = "basalt-jobs-runner"
  }

  associations = {
    eks = {
      cluster_name = local.cluster_name
    }
  }
}

module "otel_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.7.0"

  name = "pod-identity-basalt-otel"
  additional_policy_arns = {
    custom = aws_iam_policy.otel_processor.arn
  }

  association_defaults = {
    namespace       = "basalt"
    service_account = "basalt-otel-sqs-processor"
  }

  associations = {
    eks = {
      cluster_name = local.cluster_name
    }
  }
}
