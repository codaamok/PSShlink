function Get-ShlinkVisitsOrphan {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
        PS C:\> 
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [datetime]$StartDate,

        [Parameter()]
        [datetime]$EndDate,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    try {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    }
    catch {
        Write-Error -ErrorRecord $_ -ErrorAction "Stop"
    }
    
    $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

    $Params = @{
        Endpoint = "visits"
        Path = "orphan"
        PropertyTree = "visits", "data"
    }

    switch ($PSBoundParameters.Keys) {
        "StartDate" {
            $QueryString.Add("startDate", (Get-Date $StartDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
        }
        "EndDate" {
            $QueryString.Add("endDate", (Get-Date $EndDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
        }
    }

    $Params["Query"] = $QueryString
        
    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}