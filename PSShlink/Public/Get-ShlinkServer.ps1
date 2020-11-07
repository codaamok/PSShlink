function Get-ShlinkServer {
    <#
    .SYNOPSIS
        Checks the healthiness of the service, making sure it can access required resources.
    .DESCRIPTION
        Checks the healthiness of the service, making sure it can access required resources.

        https://api-spec.shlink.io/#/Monitoring/health
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
    begin {
        GetShlinkConnection -Server $ShlinkServer -ServerOnly
    }
    process {
        $Uri = "{0}/rest/health" -f $Script:ShlinkServer
    
        Invoke-RestMethod -Uri $Uri
    }
    end {
    }
}