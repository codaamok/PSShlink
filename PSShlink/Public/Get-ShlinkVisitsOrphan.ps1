function Get-ShlinkVisitsOrphan {
    <#
    .SYNOPSIS
        Get the list of visits to invalid short URLs, the base URL or any other 404.
    .DESCRIPTION
        Get the list of visits to invalid short URLs, the base URL or any other 404.
    .PARAMETER StartDate
        A datetime object to filter the visit data where the start date is equal or greater than this value. 
    .PARAMETER EndDate
        A datetime object to filter the visit data where its end date is equal or less than this value. 
    .PARAMETER ExcludeBots
        Exclude visits from bots or crawlers.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkVisitsOrphan

        Get the list of visits to invalid short URLs, the base URL or any other 404.
    .EXAMPLE
        PS C:\> Get-ShlinkVisitsOrphan -StartDate (Get-Date "2020-11-01") -EndDate (Get-Date "2020-12-01") -ExcludeBots

        Get the list of visits to invalid short URLs, the base URL or any other 404, for the whole of November and excluding bots/crawlers.
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
        [Switch]$ExcludeBots,

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
        "ExcludeBots" {
            $QueryString.Add("excludeBots", "true")
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