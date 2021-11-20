#
# Module manifest for module 'PSShlink'
#
# Generated by: Adam Cook (@codaamok)
#
# Generated on: 11/20/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSShlink.psm1'

# Version number of this module.
ModuleVersion = '0.8.0'

# Supported PSEditions
CompatiblePSEditions = 'Core', 'Desktop'

# ID used to uniquely identify this module
GUID = 'c9acdd6c-96d0-4a8a-9cce-df8fdeabc25d'

# Author of this module
Author = 'Adam Cook (@codaamok)'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) Adam Cook (@codaamok). All rights reserved.'

# Description of the functionality provided by this module
Description = 'An unofficial PowerShell module for Shlink (https://shlink.io), an open-source self-hosted and PHP-based URL shortener application'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'PSShlink.Format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-ShlinkDomains', 'Get-ShlinkServer', 'Get-ShlinkTags', 
               'Get-ShlinkUrl', 'Get-ShlinkVisits', 'Get-ShlinkVisitsOrphan', 
               'New-ShlinkTag', 'New-ShlinkUrl', 'Remove-ShlinkTag', 
               'Remove-ShlinkUrl', 'Save-ShlinkUrlQrCode', 
               'Set-ShlinkDomainRedirects', 'Set-ShlinkTag', 'Set-ShlinkUrl'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Shlink','url-shortener'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/codaamok/PSShlink/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/codaamok/PSShlink'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '# Added
- Improved build pipeline to use [codaamok.build](https://github.com/codaamok/codaamok.build)
- New -ForwardQuery boolean parameter in New-ShlinkUrl and Set-ShlinkUrl (new in Shlink 2.9.0).
# Changed
- Minimum Shlink version updated to 2.9.0
- Renamed parameter -DoNotValidateUrl of switch type to -ValidateUrl of boolean type for both New-ShlinkUrl and Set-ShlinkUrl.
- Parameter -FindIfExists is now of type boolean instead of switch in New-ShlinkUrl. is now a switch and not a boolean.
- Removed use of methods SecureStringToBSTR and PtrToStringAuto from Marshal .NET class for secure string handling in InvokeShlinkRestMethod, in favour of using GetNetworkCredential method from a PSCredential object.
- Save-ShlinkUrlQrCode no longer has hardcoded default parameter values (much like the API did) for size, margin, format, and error correction level.. Shlink 2.9.0 now lets you configure these defaults for QR codes, so by omitting values for these params, your server default values are used.
# Fixed
- Corrected object reference to API URL attempted in ErrorRecord'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

