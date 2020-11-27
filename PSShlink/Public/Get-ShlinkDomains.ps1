function Get-ShlinkDomains {
    <#
    .SYNOPSIS
        Returns the list of all domains ever used, with a flag that tells if they are the default domain
    .DESCRIPTION
        Returns the list of all domains ever used, with a flag that tells if they are the default domain
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.    
    .EXAMPLE
        PS C:\> Get-ShlinkDomains

        Returns the list of all domains ever used, with a flag that tells if they are the default domain
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

    $Params = @{
        Endpoint     = "domains"
        PropertyTree = "domains", "data"
        ErrorAction  = "Stop"
    }

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}