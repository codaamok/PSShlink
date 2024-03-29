# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.12.2] - 2023-03-06
### Fixed
- Show comment based help correctly for `Invoke-ShlinkRestMethod`, mostly for PlatyPS and in-repository help markdown files

## [0.12.0] - 2023-03-05
### Added
- New function Invoke-ShlinkRestMethod. This function will provide people with flexibility to use Shlink's REST API more directly if necessary; without the need to use this module's functions. Useful in scenarios where Shlink is updated with a breaking change or new endpoint not yet supported in PSShlink

### Changed
- Changed the way the internal function `InvokeShlinkRestMethod` discovered the pagination property; this enabled a more user friendly implementation of the new public function `Invoke-ShlinkRestMethod`
- Deprecation warning added to `Set-ShlinkUrl` for `-ValidateUrl`, which is true since Shlink 3.5.0

## [0.11.0] - 2023-03-03
### Added
- Added `-AndroidLongUrl` and `-IOSLongUrl` and `-DesktopLongUrl` to `Set-Shlinkurl`
- Added `-AndroidLongUrl` and `-IOSLongUrl` and `-DesktopLongUrl` to `New-Shlinkurl`
- Added `-ExcludeMaxVisitsReached` and `-ExcludePastValidUntil` to `Get-ShlinkUrl`
- Added `-OrderBy` permitted values `nonBotVisits-ASC` and `nonBotVisits-DESC` to `Get-ShlinkUrl`

### Changed
- Minimum Shlink version updated to 3.5.0
- Deprecation warning added to `New-ShlinkUrl` for `-ValidateUrl`, which is true since Shlink 3.5.0
- Changed API permission to 3, from 2

## [0.10.2] - 2022-04-23
### Fixed
- Updated comment based help for `Get-ShlinkVisits` for new domain parameter set

## [0.10.0] - 2022-04-23
### Added
- `Get-ShlinkVisits` has a new parameter set to enable you to retrieve all visits for just domains. This supports the new `GET /domains/{domain}/visits` endpoint in 3.1.0.

### Changed
- Minimum Shlink version updated 3.1.0

## [0.9.4] - 2022-02-26
### Added
- New parameter `-PassThru` added to function `Save-ShlinkUrlQrCode` which will return a `System.IO.FileSystemInfo` object for each QR code image file it creates when used. Default behaviour has not changed (return no object if successful).

### Changed
- Renamed parameter `-Tags` to be `-Tag` for function `Remove-ShlinkTag`

## [0.9.1] - 2022-02-14
### Fixed
- Updated minimum version check of Shlink instance to 3.0.0
- Updated comment based help for `Get-ShlinkVisistNonOrphan` as it was copied from `Get-ShlinkVisitsOprhan`

## [0.9.0] - 2022-02-13
### Added
- Function `Get-ShlinkUrl` has new parameter `-TagsMode`, new in Shlink 3.0.0
- Function `Get-ShlinkTags` has new parameter `-SearchTerm`, new in Shlink 3.0.0
- New function `Get-ShlinkVisitsNonOrphan`, new endpoint in Shlink 3.0.0
- New parameter `-RoundBlockSize` for `Save-ShlinkUrlQrCode`

### Changed
- `Get-ShlinkTags` uses the new `/tags/stats` endpoint to include stats in the data returned. This change is purely internal of the function, does not impact how the function is used or how the data is returned.
- `Get-ShlinkDomains` now includes two parent properties when data is returned: `data` and `defaultRedirects`. In Shlink 2.10.0, this endpoint was updated to include the `defaultRedirects` property. Previously, all that was returned was everything within the `data` property.
- New parameter set of possible values for `-OrderBy` parameter of `Get-ShlinkUrl` function: `longUrl-ASC`, `longUrl-DESC`, `shortCode-ASC`, `shortCode-DESC`, `dateCreated-ASC`, `dateCreated-DESC`, `visits-ASC`, `visits-DESC`, `title-ASC`, and `title-DESC`

### Removed
- Function `New-ShlinKTag` as the endpoint was removed from Shlink REST API in 3.0.0

### Fixed
- `Remove-ShlinkTag` ShouldProcess prompts listed the entire array of tags passed to it, rather than the current iterable it was working on

## [0.8.2] - 2021-11-21
### Fixed
- Renamed parameter `DoNotValidateUrl` to `ValidateUrl` in comment based help for `Set-ShlinkUrl`

## [0.8.1] - 2021-11-21

### Fixed
- Updated warnings about minimum Shlink version to suggest 2.9.0

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

[Unreleased]: https://github.com/codaamok/PSShlink/compare/0.12.2..HEAD
[0.12.2]: https://github.com/codaamok/PSShlink/compare/0.12.0..0.12.2
[0.12.0]: https://github.com/codaamok/PSShlink/compare/0.11.0..0.12.0
[0.11.0]: https://github.com/codaamok/PSShlink/compare/0.10.2..0.11.0
[0.10.2]: https://github.com/codaamok/PSShlink/compare/0.10.0..0.10.2
[0.10.0]: https://github.com/codaamok/PSShlink/compare/0.9.4..0.10.0
[0.9.4]: https://github.com/codaamok/PSShlink/compare/0.9.1..0.9.4
[0.9.1]: https://github.com/codaamok/PSShlink/compare/0.9.0..0.9.1
[0.9.0]: https://github.com/codaamok/PSShlink/compare/0.8.2..0.9.0
[0.8.2]: https://github.com/codaamok/PSShlink/compare/0.8.1..0.8.2
[0.8.1]: https://github.com/codaamok/PSShlink/compare/0.8.0..0.8.1
[0.8.0]: https://github.com/codaamok/PSShlink/compare/0.7.0..0.8.0
[0.7.0]: https://github.com/codaamok/PSShlink/compare/0.6.0..0.7.0
[0.6.0]: https://github.com/codaamok/PSShlink/compare/0.5.0..0.6.0
[0.5.0]: https://github.com/codaamok/PSShlink/compare/0.4.0..0.5.0
[0.4.0]: https://github.com/codaamok/PSShlink/compare/0.3.0..0.4.0
[0.3.0]: https://github.com/codaamok/PSShlink/compare/0.2.0..0.3.0
[0.2.0]: https://github.com/codaamok/PSShlink/compare/0.1.0..0.2.0
[0.1.0]: https://github.com/codaamok/PSShlink/tree/0.1.0