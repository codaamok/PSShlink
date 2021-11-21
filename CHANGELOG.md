# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.8.0] - 2021-11-20
### Added
- Improved build pipeline to use [codaamok.build](https://github.com/codaamok/codaamok.build)
- New `-ForwardQuery` boolean parameter in `New-ShlinkUrl` and `Set-ShlinkUrl` (new in Shlink 2.9.0).

### Changed
- Minimum Shlink version updated to 2.9.0
- Renamed parameter `-DoNotValidateUrl` of switch type to `-ValidateUrl` of boolean type for both `New-ShlinkUrl` and `Set-ShlinkUrl`.
- Parameter `-FindIfExists` is now of type boolean instead of switch in `New-ShlinkUrl`. is now a switch and not a boolean`.
- Removed use of methods `SecureStringToBSTR` and `PtrToStringAuto` from Marshal .NET class for secure string handling in `InvokeShlinkRestMethod`, in favour of using `GetNetworkCredential` method from a PSCredential object.
- `Save-ShlinkUrlQrCode` no longer has hardcoded default parameter values (much like the API did) for size, margin, format, and error correction level.. Shlink 2.9.0 now lets you configure these defaults for QR codes, so by omitting values for these params, your server default values are used.

### Fixed
- Updated warnings about minimum Shlink version to suggest 2.9.0
- Corrected object reference to API URL attempted in ErrorRecord

## [0.7.0] - 2021-08-09
### Added
- New function `Set-ShlinkDomainRedirects`, new in Shlink 2.8.0
- New `-ErrorCorrection` parameter for `Save-ShlinkUrlQrCode`, new in Shlink 2.8.0

### Changed
- Minimum Shlink version updated to 2.8.0

### Fixed
- Return exception `UnauthorizedAccessException` when Shlink returns 401. Previously `InvalidOperationException` was returned

### Security
- Default to https:// as -ShlinkServer if schema is not provided. Largely for security but also because of https://github.com/PowerShell/PowerShell/issues/14531

## [0.6.0] - 2021-05-23
### Added
- New `-ExcludeBots` parameter to `Get-ShlinkVisits` and `Get-ShlinkVisitsOrphan`, new in Shlink 2.7.0
- New `-Crawlable` parameter to `New-ShlinkUrl` and `Set-ShlinkUrl`, new in Shlink 2.7.0

### Changed
- `Set-ShlinkUrl` accepts `domain` as ValueFromPipelineByPropertyName
- Minimum Shlink version updated to 2.7.0

### Fixed
- Fixed an issue where `Set-ShlinkUrl` would not reinitialise its query string when used within a pipeline
- Added missing comment based help to `Get-ShlinkVisitsOrphan`
- Fixed typos in comment based help for some functions

## [0.5.0] - 2021-02-14
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

[Unreleased]: https://github.com/codaamok/PSShlink/compare/0.8.0..HEAD
[0.8.0]: https://github.com/codaamok/PSShlink/compare/0.7.0..0.8.0
[0.7.0]: https://github.com/codaamok/PSShlink/compare/0.6.0..0.7.0
[0.6.0]: https://github.com/codaamok/PSShlink/compare/0.5.0..0.6.0
[0.5.0]: https://github.com/codaamok/PSShlink/compare/0.4.0..0.5.0
[0.4.0]: https://github.com/codaamok/PSShlink/compare/0.3.0..0.4.0
[0.3.0]: https://github.com/codaamok/PSShlink/compare/0.2.0..0.3.0
[0.2.0]: https://github.com/codaamok/PSShlink/compare/0.1.0..0.2.0
[0.1.0]: https://github.com/codaamok/PSShlink/tree/0.1.0