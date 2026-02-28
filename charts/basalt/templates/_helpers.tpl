{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "basalt.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.api.image) "context" $) -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname
*/}}
{{- define "basalt.api.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname (with namespace)
(removing image- prefix to avoid name length issues)
*/}}
{{- define "basalt.api.fullname.namespace" -}}
{{- printf "%s-%s" (include "common.names.fullname.namespace" .) "api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper api image name
*/}}
{{- define "basalt.api.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.api.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create -}}
    {{ default (include "basalt.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.api.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes Public API fullname
*/}}
{{- define "basalt.public-api.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "public-api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes Public API fullname (with namespace)
(removing image- prefix to avoid name length issues)
*/}}
{{- define "basalt.public-api.fullname.namespace" -}}
{{- printf "%s-%s" (include "common.names.fullname.namespace" .) "public-api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper public-api image name
*/}}
{{- define "basalt.public-api.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.publicApi.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.public-api.serviceAccountName" -}}
{{- if .Values.publicApi.serviceAccount.create -}}
    {{ default (include "basalt.public-api.fullname" .) .Values.publicApi.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.publicApi.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes OTel Collector fullname
*/}}
{{- define "basalt.otel-collector.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "otel-collector" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes OTel Collector fullname (with namespace)
(removing image- prefix to avoid name length issues)
*/}}
{{- define "basalt.otel-collector.fullname.namespace" -}}
{{- printf "%s-%s" (include "common.names.fullname.namespace" .) "otel-collector" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper otel-collector image name
*/}}
{{- define "basalt.otel-collector.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.otelCollector.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.otel-collector.serviceAccountName" -}}
{{- if .Values.otelCollector.serviceAccount.create -}}
    {{ default (include "basalt.otel-collector.fullname" .) .Values.otelCollector.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.otelCollector.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes migration fullname
*/}}
{{- define "basalt.migration.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "migration" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper migration image name
*/}}
{{- define "basalt.migration.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.migration.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname
*/}}
{{- define "basalt.web-app.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper web-app image name
*/}}
{{- define "basalt.web-app.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.webApp.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.web-app.serviceAccountName" -}}
{{- if .Values.webApp.serviceAccount.create -}}
    {{ default (include "basalt.web-app.fullname" .) .Values.webApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.webApp.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname
*/}}
{{- define "basalt.jobs-runner.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "jobs-runner" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper jobs-runner image name
*/}}
{{- define "basalt.jobs-runner.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jobsRunner.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.jobs-runner.serviceAccountName" -}}
{{- if .Values.jobsRunner.serviceAccount.create -}}
    {{ default (include "basalt.jobs-runner.fullname" .) .Values.jobsRunner.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jobsRunner.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname
*/}}
{{- define "basalt.otel-sqs-processor.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "otel-sqs-processor" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper otel-sqs-processor image name
*/}}
{{- define "basalt.otel-sqs-processor.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.otelSqsProcessor.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.otel-sqs-processor.serviceAccountName" -}}
{{- if .Values.otelSqsProcessor.serviceAccount.create -}}
    {{ default (include "basalt.otel-sqs-processor.fullname" .) .Values.otelSqsProcessor.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.otelSqsProcessor.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname
*/}}
{{- define "basalt.script-evaluator.fullname" -}}
{{- printf "%s-%s" (include "common.names.fullname" .) "script-evaluator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Basalt Kubernetes API fullname (with namespace)
(removing image- prefix to avoid name length issues)
*/}}
{{- define "basalt.script-evaluator.fullname.namespace" -}}
{{- printf "%s-%s" (include "common.names.fullname.namespace" .) "script-evaluator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper script-evaluator image name
*/}}
{{- define "basalt.script-evaluator.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.scriptEvaluator.image "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "basalt.script-evaluator.serviceAccountName" -}}
{{- if .Values.scriptEvaluator.serviceAccount.create -}}
    {{ default (include "basalt.script-evaluator.fullname" .) .Values.scriptEvaluator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.scriptEvaluator.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "basalt.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Redis environment variables (scheme, host, port, username, password)
*/}}
{{- define "basalt.redisEnvVars" -}}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.schemeKey }}
- name: REDIS_SCHEME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalRedis.existingSecret }}
      key: {{ .Values.externalRedis.schemeKey }}
{{- else }}
- name: REDIS_SCHEME
  value: {{ .Values.externalRedis.scheme | quote }}
{{- end }}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.hostKey }}
- name: REDIS_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalRedis.existingSecret }}
      key: {{ .Values.externalRedis.hostKey }}
{{- else }}
- name: REDIS_HOST
  value: {{ .Values.externalRedis.host | quote }}
{{- end }}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.portKey }}
- name: REDIS_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalRedis.existingSecret }}
      key: {{ .Values.externalRedis.portKey }}
{{- else }}
- name: REDIS_PORT
  value: {{ .Values.externalRedis.port | quote }}
{{- end }}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.usernameKey }}
- name: REDIS_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalRedis.existingSecret }}
      key: {{ .Values.externalRedis.usernameKey }}
{{- else }}
- name: REDIS_USERNAME
  value: {{ .Values.externalRedis.username | quote }}
{{- end }}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.passwordKey }}
- name: REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalRedis.existingSecret }}
      key: {{ .Values.externalRedis.passwordKey }}
{{- else }}
- name: REDIS_PASSWORD
  value: {{ .Values.externalRedis.password | quote }}
{{- end }}
{{- end -}}

{{/*
Common environment variables for Basalt services
*/}}
{{- define "basalt.commonEnvVars" -}}
- name: NODE_ENV
  value: production
- name: AWS_REGION
  value: {{ .Values.config.region | quote }}
{{- if .Values.scriptEvaluator.enabled }}
- name: SCRIPT_EVALUATOR_SERVICE_URL
  value: {{ printf "http://%s:%v" (include "basalt.script-evaluator.fullname" .) .Values.scriptEvaluator.service.ports.http | quote }}
{{- else }}
- name: EVALUATOR_SCRIPT_FUNCTION_NAME
  value: {{ .Values.config.lambdaScriptEvaluatorName | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.hostKey }}
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.hostKey }}
{{- else }}
- name: DB_HOST
  value: {{ .Values.externalPostgres.host | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.hostKey }}
- name: DB_HOST_REPLICA
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.hostKey }}
{{- else }}
- name: DB_HOST_REPLICA
  value: {{ .Values.externalPostgres.host | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.userKey }}
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.userKey }}
{{- else }}
- name: DB_USER
  value: {{ .Values.externalPostgres.user | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.passwordKey }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.passwordKey }}
{{- else }}
- name: DB_PASSWORD
  value: {{ .Values.externalPostgres.password | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.portKey }}
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.portKey }}
{{- else }}
- name: DB_PORT
  value: {{ .Values.externalPostgres.port | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.databaseKey }}
- name: DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.databaseKey }}
{{- else }}
- name: DB_NAME
  value: {{ .Values.externalPostgres.database | quote }}
{{- end }}
{{- if and .Values.externalPostgres.existingSecret .Values.externalPostgres.sslmodeKey }}
- name: PGSSLMODE
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalPostgres.existingSecret }}
      key: {{ .Values.externalPostgres.sslmodeKey }}
{{- else }}
- name: PGSSLMODE
  value: {{ .Values.externalPostgres.sslmode | quote }}
{{- end }}
- name: API_HOST
  value: {{ .Values.config.apiUrl | quote }}
- name: DASHBOARD_HOST
  value: {{ .Values.config.dashboardUrl | quote }}
{{- if and .Values.config.sessionSecretExistingSecret .Values.config.sessionSecretKey }}
- name: SESSION_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.sessionSecretExistingSecret }}
      key: {{ .Values.config.sessionSecretKey }}
{{- else }}
- name: SESSION_SECRET
  value: {{ .Values.config.sessionSecret | quote }}
{{- end }}
{{- if and .Values.config.encryptionKeyExistingSecret .Values.config.encryptionKeySecretKey }}
- name: ENCRYPTION_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.encryptionKeyExistingSecret }}
      key: {{ .Values.config.encryptionKeySecretKey }}
{{- else }}
- name: ENCRYPTION_KEY
  value: {{ .Values.config.encryptionKey | quote }}
{{- end }}
- name: GOOGLE_LOGIN_ENABLED
  value: {{ .Values.config.auth.google.enabled | quote }}
{{- if .Values.config.auth.google.enabled }}
{{- if and .Values.config.auth.google.existingSecret .Values.config.auth.google.clientIdKey }}
- name: GOOGLE_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.auth.google.existingSecret }}
      key: {{ .Values.config.auth.google.clientIdKey }}
{{- else }}
- name: GOOGLE_CLIENT_ID
  value: {{ .Values.config.auth.google.clientId | quote }}
{{- end }}
{{- if and .Values.config.auth.google.existingSecret .Values.config.auth.google.clientSecretKey }}
- name: GOOGLE_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.auth.google.existingSecret }}
      key: {{ .Values.config.auth.google.clientSecretKey }}
{{- else }}
- name: GOOGLE_CLIENT_SECRET
  value: {{ .Values.config.auth.google.clientSecret | quote }}
{{- end }}
{{- end }}
- name: ONELOGIN_ENABLED
  value: {{ .Values.config.auth.oneLogin.enabled | quote }}
{{- if .Values.config.auth.oneLogin.enabled }}
- name: DEFAULT_LOGIN_WORKSPACE_ID
  value: {{ .Values.config.auth.oneLogin.defaultLoginWorkspaceId | quote }}
{{- if and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.clientIdKey }}
- name: ONELOGIN_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.auth.oneLogin.existingSecret }}
      key: {{ .Values.config.auth.oneLogin.clientIdKey }}
{{- else }}
- name: ONELOGIN_CLIENT_ID
  value: {{ .Values.config.auth.oneLogin.clientId | quote }}
{{- end }}
{{- if and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.clientSecretKey }}
- name: ONELOGIN_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.auth.oneLogin.existingSecret }}
      key: {{ .Values.config.auth.oneLogin.clientSecretKey }}
{{- else }}
- name: ONELOGIN_CLIENT_SECRET
  value: {{ .Values.config.auth.oneLogin.clientSecret | quote }}
{{- end }}
{{- if and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.issuerKey }}
- name: ONELOGIN_ISSUER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.auth.oneLogin.existingSecret }}
      key: {{ .Values.config.auth.oneLogin.issuerKey }}
{{- else }}
- name: ONELOGIN_ISSUER
  value: {{ .Values.config.auth.oneLogin.issuer | quote }}
{{- end }}
- name: ONELOGIN_ROLE_ADMIN
  value: {{ .Values.config.auth.oneLogin.roles.admin | quote }}
- name: ONELOGIN_ROLE_ENGINEER
  value: {{ .Values.config.auth.oneLogin.roles.engineer | quote }}
- name: ONELOGIN_ROLE_BUILDER
  value: {{ .Values.config.auth.oneLogin.roles.builder | quote }}
- name: ONELOGIN_ROLE_VIEWER
  value: {{ .Values.config.auth.oneLogin.roles.viewer | quote }}
- name: ONELOGIN_DEFAULT_ROLE
  value: {{ .Values.config.auth.oneLogin.defaultRole | quote }}
{{- end }}
- name: PASSWORD_LOGIN_ENABLED
  value: {{ .Values.config.auth.email.enabled | quote }}
- name: SIGNUP_ENABLED
  value: {{ .Values.config.auth.signupEnabled | quote }}
- name: AWS_BUCKET_NAME
  value: {{ .Values.storage.bucket | quote }}
- name: AWS_PRIVATE_UPLOAD_BUCKET_NAME
  value: {{ .Values.storage.privateBucket | quote }}
- name: MONITORING_INGESTION_BUCKET
  value: {{ .Values.storage.otelBucket | quote }}
{{- if and .Values.externalClickhouse.existingSecret .Values.externalClickhouse.urlKey }}
- name: CLICKHOUSE_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalClickhouse.existingSecret }}
      key: {{ .Values.externalClickhouse.urlKey }}
{{- else }}
- name: CLICKHOUSE_URL
  value: {{ .Values.externalClickhouse.url | quote }}
{{- end }}
{{- if and .Values.externalClickhouse.existingSecret .Values.externalClickhouse.userKey }}
- name: CLICKHOUSE_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalClickhouse.existingSecret }}
      key: {{ .Values.externalClickhouse.userKey }}
{{- else }}
- name: CLICKHOUSE_USER
  value: {{ .Values.externalClickhouse.user | quote }}
{{- end }}
{{- if and .Values.externalClickhouse.existingSecret .Values.externalClickhouse.passwordKey }}
- name: CLICKHOUSE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalClickhouse.existingSecret }}
      key: {{ .Values.externalClickhouse.passwordKey }}
{{- else }}
- name: CLICKHOUSE_PASSWORD
  value: {{ .Values.externalClickhouse.password | quote }}
{{- end }}
{{- if and .Values.externalClickhouse.existingSecret .Values.externalClickhouse.databaseKey }}
- name: CLICKHOUSE_DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalClickhouse.existingSecret }}
      key: {{ .Values.externalClickhouse.databaseKey }}
{{- else }}
- name: CLICKHOUSE_DB_NAME
  value: {{ .Values.externalClickhouse.database | quote }}
{{- end }}
{{- include "basalt.redisEnvVars" . }}
{{- if and .Values.externalRedis.existingSecret .Values.externalRedis.schemeKey .Values.externalRedis.hostKey .Values.externalRedis.portKey }}
{{/* REDIS_URL cannot be composed when using secrets */}}
{{- else }}
- name: REDIS_URL
  value: {{ printf "%s%s:%s" .Values.externalRedis.scheme .Values.externalRedis.host (toString .Values.externalRedis.port) | quote }}
{{- end }}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "basalt.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "basalt.validateValues.config" .) -}}
{{- $messages := append $messages (include "basalt.validateValues.postgres" .) -}}
{{- $messages := append $messages (include "basalt.validateValues.clickhouse" .) -}}
{{- $messages := append $messages (include "basalt.validateValues.redis" .) -}}
{{- $messages := append $messages (include "basalt.validateValues.storage" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Validate config values
*/}}
{{- define "basalt.validateValues.config" -}}
{{- if not .Values.config.region -}}
basalt: config.region
    config.region is required. Please set a value.
{{- end -}}
{{- if and (not .Values.scriptEvaluator.enabled) (not .Values.config.lambdaScriptEvaluatorName) -}}
basalt: config.lambdaScriptEvaluatorName
    config.lambdaScriptEvaluatorName is required when scriptEvaluator.enabled is false. Please set a value.
{{- end -}}
{{- if not .Values.config.apiUrl -}}
basalt: config.apiUrl
    config.apiUrl is required. Please set a value.
{{- end -}}
{{- if not .Values.config.dashboardUrl -}}
basalt: config.dashboardUrl
    config.dashboardUrl is required. Please set a value.
{{- end -}}
{{- if and (not .Values.config.sessionSecretExistingSecret) (not .Values.config.sessionSecret) -}}
basalt: config.sessionSecret
    Either config.sessionSecret or config.sessionSecretExistingSecret with config.sessionSecretKey must be set.
{{- end -}}
{{- if and (not .Values.config.encryptionKeyExistingSecret) (not .Values.config.encryptionKey) -}}
basalt: config.encryptionKey
    Either config.encryptionKey or (config.encryptionKeyExistingSecret and config.encryptionKeySecretKey) must be set.
{{- end -}}
{{- if and .Values.config.encryptionKeyExistingSecret (not .Values.config.encryptionKeySecretKey) -}}
basalt: config.encryptionKeySecretKey
    config.encryptionKeySecretKey is required when config.encryptionKeyExistingSecret is set.
{{- end -}}
{{- if and .Values.config.encryptionKeySecretKey (not .Values.config.encryptionKeyExistingSecret) -}}
basalt: config.encryptionKeyExistingSecret
    config.encryptionKeyExistingSecret is required when config.encryptionKeySecretKey is set.
{{- end -}}
{{- if not (or .Values.config.auth.google.enabled .Values.config.auth.email.enabled .Values.config.auth.oneLogin.enabled) -}}
basalt: config.auth
    At least one authentication method must be enabled (config.auth.google.enabled, config.auth.email.enabled, or config.auth.oneLogin.enabled).
{{- end -}}
{{- if .Values.config.auth.google.enabled -}}
{{- if and (not .Values.config.auth.google.clientId) (not (and .Values.config.auth.google.existingSecret .Values.config.auth.google.clientIdKey)) -}}
basalt: config.auth.google.clientId
    Either config.auth.google.clientId or (config.auth.google.existingSecret and config.auth.google.clientIdKey) must be set when Google auth is enabled.
{{- end -}}
{{- if and (not .Values.config.auth.google.clientSecret) (not (and .Values.config.auth.google.existingSecret .Values.config.auth.google.clientSecretKey)) -}}
basalt: config.auth.google.clientSecret
    Either config.auth.google.clientSecret or (config.auth.google.existingSecret and config.auth.google.clientSecretKey) must be set when Google auth is enabled.
{{- end -}}
{{- end -}}
{{- if .Values.config.auth.oneLogin.enabled -}}
{{- if and (not .Values.config.auth.oneLogin.clientId) (not (and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.clientIdKey)) -}}
basalt: config.auth.oneLogin.clientId
    Either config.auth.oneLogin.clientId or (config.auth.oneLogin.existingSecret and config.auth.oneLogin.clientIdKey) must be set when OneLogin auth is enabled.
{{- end -}}
{{- if and (not .Values.config.auth.oneLogin.clientSecret) (not (and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.clientSecretKey)) -}}
basalt: config.auth.oneLogin.clientSecret
    Either config.auth.oneLogin.clientSecret or (config.auth.oneLogin.existingSecret and config.auth.oneLogin.clientSecretKey) must be set when OneLogin auth is enabled.
{{- end -}}
{{- if and (not .Values.config.auth.oneLogin.issuer) (not (and .Values.config.auth.oneLogin.existingSecret .Values.config.auth.oneLogin.issuerKey)) -}}
basalt: config.auth.oneLogin.issuer
    Either config.auth.oneLogin.issuer or (config.auth.oneLogin.existingSecret and config.auth.oneLogin.issuerKey) must be set when OneLogin auth is enabled.
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate PostgreSQL values
*/}}
{{- define "basalt.validateValues.postgres" -}}
{{- if and (not .Values.externalPostgres.existingSecret) (not .Values.externalPostgres.host) -}}
basalt: externalPostgres.host
    Either externalPostgres.host or externalPostgres.existingSecret with externalPostgres.hostKey must be set.
{{- end -}}
{{- if and (not .Values.externalPostgres.existingSecret) (not .Values.externalPostgres.user) -}}
basalt: externalPostgres.user
    Either externalPostgres.user or externalPostgres.existingSecret with externalPostgres.userKey must be set.
{{- end -}}
{{- if and (not .Values.externalPostgres.existingSecret) (not .Values.externalPostgres.password) -}}
basalt: externalPostgres.password
    Either externalPostgres.password or externalPostgres.existingSecret with externalPostgres.passwordKey must be set.
{{- end -}}
{{- if and (not .Values.externalPostgres.existingSecret) (not .Values.externalPostgres.database) -}}
basalt: externalPostgres.database
    Either externalPostgres.database or externalPostgres.existingSecret with externalPostgres.databaseKey must be set.
{{- end -}}
{{- end -}}

{{/*
Validate Clickhouse values
*/}}
{{- define "basalt.validateValues.clickhouse" -}}
{{- if and (not .Values.externalClickhouse.existingSecret) (not .Values.externalClickhouse.url) -}}
basalt: externalClickhouse.url
    Either externalClickhouse.url or externalClickhouse.existingSecret with externalClickhouse.urlKey must be set.
{{- end -}}
{{- if and (not .Values.externalClickhouse.existingSecret) (not .Values.externalClickhouse.user) -}}
basalt: externalClickhouse.user
    Either externalClickhouse.user or externalClickhouse.existingSecret with externalClickhouse.userKey must be set.
{{- end -}}
{{- if and (not .Values.externalClickhouse.existingSecret) (not .Values.externalClickhouse.password) -}}
basalt: externalClickhouse.password
    Either externalClickhouse.password or externalClickhouse.existingSecret with externalClickhouse.passwordKey must be set.
{{- end -}}
{{- if and (not .Values.externalClickhouse.existingSecret) (not .Values.externalClickhouse.database) -}}
basalt: externalClickhouse.database
    Either externalClickhouse.database or externalClickhouse.existingSecret with externalClickhouse.databaseKey must be set.
{{- end -}}
{{- end -}}

{{/*
Validate Redis values
*/}}
{{- define "basalt.validateValues.redis" -}}
{{- if and (not .Values.externalRedis.existingSecret) (not .Values.externalRedis.scheme) -}}
basalt: externalRedis.scheme
    Either externalRedis.scheme or externalRedis.existingSecret with externalRedis.schemeKey must be set.
{{- end -}}
{{- if and (not .Values.externalRedis.existingSecret) (not .Values.externalRedis.host) -}}
basalt: externalRedis.host
    Either externalRedis.host or externalRedis.existingSecret with externalRedis.hostKey must be set.
{{- end -}}
{{- end -}}

{{/*
Validate Storage values
*/}}
{{- define "basalt.validateValues.storage" -}}
{{- if not .Values.storage.bucket -}}
basalt: storage.bucket
    storage.bucket is required. Please set a value.
{{- end -}}
{{- if not .Values.storage.privateBucket -}}
basalt: storage.privateBucket
    storage.privateBucket is required. Please set a value.
{{- end -}}
{{- if not .Values.storage.otelBucket -}}
basalt: storage.otelBucket
    storage.otelBucket is required. Please set a value.
{{- end -}}
{{- end -}}