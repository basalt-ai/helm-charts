<p align="center">
  <img src="assets/images/logo.png?raw=true" alt="Basalt logo"/>
</p>

## Basalt Helm Charts

## Installation

```
helm repo add basalt https://helm.getbasalt.ai
helm repo update
helm install basalt basalt/basalt -n basalt
```

An example `values.yaml` is available [here](charts/basalt/values-example.yaml), it corresponds to a minimal installation of the application using the Helm chart.

## AWS resources

An example Terraform file is available [here](main.tf), it should cover what needs to be created to run the application on AWS.

## SSO

### OneLogin

The callback URL to configure in OneLogin is:

```
https://{api_url}/auth/onelogin/callback
```

The Authentication Method must be set to `POST`.


## Known issues / limitations:

- The `arm64` image is not available, but can be added if needed.
- AWS is required to run the application (SQS, S3, S3 Notifications)