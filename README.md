# PSShlink

An unofficial PowerShell module for Shlink (https://shlink.io), an open-source self-hosted and PHP-based URL shortener application

## Functions

## Requirements

- PowerShell 5.1 or newer

## Getting started

## Authentication

Each function will have two parameters for authentication to your Shlink instance:

- `-ShlinkServer`: a string value of the Shlink server address e.g. https://example.com
- `-ShlinkApiKey`: a SecureString value for the Shlink server's API key

After using any function of PSShlink for the first time after importing the module - which have both parameters `-ShlinkServer` and `-ShlinkApiKey`* - it is not necessary to use the parameters again in subsequent uses for other functions of PSShlink. These values are held in memory for as long as the PowerShell session exists.

* Some functions do not require both `-ShlinkServer` and `-ShlinkApiKey`, e.g. `Get-ShlinkServer`. Therefore if the first function you use after importing PSShlink accepts only `-ShlinkServer`, you will not be asked again for this value by other functions of PSShlink. You will however be prompted for the API key. Again, subsequent uses of other functions will no longer require `-ShlinkServer` and `-ShlinkApiKey`.

If the first function you use after importing PSShlink requires `-ShlinkServer` and/or `-ShlinkApiKey` and you have not passed the parameter(s), you will be prompted for them.
## Examples

## Known issues

## Support