# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Minimum Shlink version updated to 2.5.0
- `Save-ShlinkUrlQrCode` now uses newer API format for the 'size' query parameter
- Check and produce a terminating error if `-ShlinkServer` is not really a Shlink server in all functions

### Fixed
- `-ShlinkServer` and `-ShlinkApiKey` only remembered the first values you use in any of the module's functions. Explicitly passing those parameters to any function again did not use the new server address or API key

## [0.2.0] - 2021-01-02
### Fixed
- Add the `System.Web` .NET class if not loaded, thanks @ChrisKibble in #1
- Parameter `-DoNotValidateUrl` now behaves correctly in `New-ShlinkUrl` and `Set-ShlinkUrl`, thanks again @ChrisKibble in #2

## [0.1.0] - 2020-10-27
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/PSShlink/compare/0.2.0..HEAD
[0.2.0]: https://github.com/codaamok/PSShlink/compare/0.1.0..0.2.0
[0.1.0]: https://github.com/codaamok/PSShlink/tree/0.1.0