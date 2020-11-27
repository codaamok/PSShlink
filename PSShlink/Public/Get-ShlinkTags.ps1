function Get-ShlinkTags {
    <#
    .SYNOPSIS
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .DESCRIPTION
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkTags
        
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

    $QueryString.Add("withStats", "true")

    $Params = @{
        Endpoint     = "tags"
        PropertyTree = "tags", "stats"
    }

    $Params["Query"] = $QueryString

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}