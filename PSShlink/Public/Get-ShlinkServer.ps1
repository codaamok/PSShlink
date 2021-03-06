function Get-ShlinkServer {
    <#
    .SYNOPSIS
        Checks the healthiness of the service, making sure it can access required resources.
    .DESCRIPTION
        Checks the healthiness of the service, making sure it can access required resources.

        https://api-spec.shlink.io/#/Monitoring/health
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkServer
        
        Returns the healthiness of the service.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer
    )

    try {
        GetShlinkConnection -Server $ShlinkServer -ServerOnly
    }
    catch {
        Write-Error -ErrorRecord $_ -ErrorAction "Stop"
    }

    $Uri = "{0}/rest/health" -f $Script:ShlinkServer

    try {
        Invoke-RestMethod -Uri $Uri -ErrorAction "Stop"
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}