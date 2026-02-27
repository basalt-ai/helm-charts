# Changelog

## [1.1.1] - 2026-02-27

### Fixed

- Some parameters had been removed in 1.1.0, they are restored in 1.1.1
- Aligned uid/gid with container users
- Updated probe settings for the various deployments

## [1.1.0] - 2026-02-27

### Changed

- `scriptEvaluator.enabled` set to `true` now deploys the Python script evaluator as a Kubernetes deployment instead of a Lambda.
- ServiceMonitors can now be added for the `api`, `public-api`, and `jobs-runner` services.
- `config.auth` has been extended to manage enabling and disabling of the different auth providers.
- OneLogin SSO has been added as a supported authentication provider.
