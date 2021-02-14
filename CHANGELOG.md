# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- New function `Get-ShlinkVisitsOrphan`, new in Shlink 2.6.0
- New `-Margin` parameter to `Save-ShlinkUrlQrCode`, new in Shlink 2.6.0
- Added missing comment based help to `Save-ShlinkUrlQrCode` for its parameters
- New `-Title` parameter to `New-ShlinkUrl` and `Set-ShlinkUrl`, new in Shlink 2.6.0

### Changed
- Improvements to the Shlink API in 2.6.0 enables me to restore the previous (intended) functionality of `Set-ShlinkUrl` is restored. Specifically, the ability to modify multiple properties of a short code within a single call. No longer need to call the function for each change you want to make to a short code.
- `Save-ShlinkUrlQrCode` now creates the directory `-Path` if it does not exist
- Minimum Shlink version updated to 2.6.0

## [0.4.0] - 2021-02-04
### Fixed
- `-ValidUntil` would be set the same as `-ValidSince` with `New-ShlinkUrl`, fixes #3 

### Changed
- In order to fix #4, I had to change the way `Set-ShlinkUrl` works. You can now only update one property of a short code per call of `Set-ShlinkUrl`.

## [0.3.0] - 2021-01-23

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

[Unreleased]: https://github.com/codaamok/PSShlink/compare/0.4.0..HEAD
[0.4.0]: https://github.com/codaamok/PSShlink/compare/0.3.0..0.4.0
[0.3.0]: https://github.com/codaamok/PSShlink/compare/0.2.0..0.3.0
[0.2.0]: https://github.com/codaamok/PSShlink/compare/0.1.0..0.2.0
[0.1.0]: https://github.com/codaamok/PSShlink/tree/0.1.0