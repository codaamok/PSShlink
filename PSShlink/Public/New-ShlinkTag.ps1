function New-ShlinkTag {
    <#
    .SYNOPSIS
        Creates one or more new tags on your Shlink server
    .DESCRIPTION
        Creates one or more new tags on your Shlink server
    .PARAMETER Tags
        Name(s) for your new tag(s)
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> New-ShlinkTag -Tags "oldwebsite","newwebsite","misc"
        
        Creates the following new tags on your Shlink server: "oldwebsite","newwebsite","misc"
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Tags,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey

    $Params = @{
        Endpoint = "tags"
        Method = "POST"
        Body = @{
            tags = @($Tags)
        }
        PropertyTree = @(
            "tags"
            "data"
        )
    }

    InvokeShlinkRestMethod @Params
}