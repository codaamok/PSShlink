# PSShlink
| Branch | Build status | Last commit | Latest release | PowerShell Gallery | GitHub |
|-|-|-|-|-|-|
| `main` | ![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/codaamok/PSShlink/Publish/main) | ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/codaamok/PSShlink/main?color=blue) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/codaamok/PSShlink?color=blue) ![GitHub Release Date](https://img.shields.io/github/release-date/codaamok/PSShlink?color=blue) | ![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSShlink?color=blue) | ![GitHub all releases](https://img.shields.io/github/downloads/codaamok/PSShlink/total?color=blue) |


An unofficial PowerShell module for Shlink (https://shlink.io), an open-source self-hosted and PHP-based URL shortener application.

## Functions

- [Get-ShlinkDomains](docs/Get-ShlinkDomains.md)
- [Get-ShlinkServer](docs/Get-ShlinkServer.md)
- [Get-ShlinkTags](docs/Get-ShlinkTags.md)
- [Get-ShlinkUrl](docs/Get-ShlinkUrl.md)
- [Get-ShlinkVisits](docs/Get-ShlinkVisits.md)
- [New-ShlinkTag](docs/New-ShlinkTag.md)
- [New-ShlinkUrl](docs/New-ShlinkUrl.md)
- [Remove-ShlinkTag](docs/Remove-ShlinkTag.md)
- [Remove-ShlinkUrl](docs/Remove-ShlinkUrl.md)
- [Save-ShlinkUrlQrCode](docs/Save-ShlinkUrlQrCode.md)
- [Set-ShlinkTag](docs/Set-ShlinkTag.md)
- [Set-ShlinkUrl](docs/Set-ShlinkUrl.md)

## Requirements

- PowerShell 5.1 or newer (including PowerShell Core, 7.0 or newer)
- Shlink 2.4.0 or newer

## Getting started

Install and import:

```powershell
PS C:\> Install-Module PSShlink -Scope CurrentUser
PS C:\> Import-Module PSShlink
```

Be sure to check out the examples below.

## Authentication

Each function will have two parameters for authentication to your Shlink instance:

- `-ShlinkServer`: a string value of the Shlink server address e.g. `https://example.com`
- `-ShlinkApiKey`: a SecureString value for the Shlink server's API key

After using any function of PSShlink for the first time after importing the module - which have both parameters `-ShlinkServer` and `-ShlinkApiKey` * - it is not necessary to use the parameters again in subsequent uses for other functions of PSShlink. These values are held in memory for as long as the PowerShell session exists.

\* Some functions do not require both `-ShlinkServer` and `-ShlinkApiKey`, e.g. `Get-ShlinkServer`. Therefore if the first function you use after importing PSShlink accepts only `-ShlinkServer`, you will not be asked again for this value by other functions of PSShlink. You will however be prompted for the API key. Again, subsequent uses of other functions will no longer require `-ShlinkServer` and `-ShlinkApiKey`.

If the first function you use after importing PSShlink requires `-ShlinkServer` and/or `-ShlinkApiKey` and you have not passed the parameter(s), you will be prompted for them.

## Examples

All functions come with complete comment based help, so it is possible to find examples for each function using `Get-Help`. For example, use the following to see detailed help including examples for `Save-ShlinkUrlQrCode`:

```powershell
PS C:\> Get-Help Save-ShlinkUrlQrCode
```

___

```powershell
PS C:\> $Key = "ba6c52ed-flk5-4e84-9fc7-9c7e34825da0" | ConvertTo-SecureString -AsPlainText -Force
PS C:\> Get-ShlinkUrl -SearchTerm "oldWebsite" -ShlinkServer "https://myshlinkserver.com" -ShlinkApiKey $Key
```

Returns all short codes which match the search term `oldWebsite`.

___

```powershell
PS C:\> Get-ShlinkUrl -SearchTerm "oldWebsite" | Remove-ShlinkUrl
```

Deletes all short codes from the Shlink server which match the search term `oldWebsite`.

___

```powershell
PS C:\> Get-ShlinkUrl -SearchTerm "newWebsite" | Save-ShlinkUrlQrCode
```

Saves QR codes for all short URLs which match the search term `newWebsite`. All files will be saved as the default values for size (300x300) and type (png). All files by default are saved in your Downloads directory using the naming convention: `ShlinkQRCode_<shortCode>_<domain>_<size>.<format>`. e.g. `ShlinkQRCode_asFk2_example-com_300.png`.

___

```powershell
PS C:\> Get-ShlinkUrl -SearchTerm "newWebsite"  | Set-ShlinkUrl -Tags "newWebsite"
```

Sets the tag `newWebsite` on all short codes matching the search term `newWebsite`.
___

```powershell
PS C:\> New-ShlinkUrl -LongUrl "https://tools.ietf.org/html/rfc2549" -CustomSlug "rfc2549" -Domain "cookadam.co.uk" -DoNotValidateUrl
```

Creates a new short code named `rfc2549` under the non-default domain `cookadam.co.uk`. The short code will redirect to `https://tools.ietf.org/html/rfc2549`. URL validation is not enforced.
## Support

If you experience any issues with PSShlink, please raise an issue on GitHub.