function Get-ShlinkVisits {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .PARAMETER ShortCode
        The name of the short code you wish to return the visits data for. For example, if the short URL is "https://example.com/new-url" then the short code is "new-url".
    .PARAMETER Tag
        The name of the tag you wish to return the visits data for.
    .PARAMETER Domain
        The domain (excluding schema) associated with the short code you wish to search for. For example, "example.com" is an acceptable value. 
        This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .PARAMETER StartDate
        A datetime object to filter the visit data where the start date is equal or greater than this value. 
    .PARAMETER EndDate
        A datetime object to filter the visit data where its end date is equal or less than this value. 
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkVists
        
        Returns the overall visit count for your Shlink server
    .EXAMPLE
        PS C:\> Get-ShlinkVisits -ShortCode "profile"
        
        Returns all visit data associated with the short code "profile"
    .EXAMPLE
        PS C:\> Get-ShlinkVisits -Tag "oldwebsite"

        Returns all the visit data for all short codes asociated with the tag "oldwebsite"
    .EXAMPLE
        PS C:\> Get-ShlinkVisits -ShortCode "profile" -StartDate (Get-Date "2020-11-01") -EndDate (Get-Date "2020-11-30")

        Returns all visit data associated with the short code "profile" for the whole of November 2020
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding(DefaultParameterSetName="Server")]
    param (
        [Parameter(Mandatory, ParameterSetName="ShortCode")]
        [String]$ShortCode,

        [Parameter(Mandatory, ParameterSetName="Tag")]
        [String]$Tag,

        [Parameter(ParameterSetName="ShortCode")]
        [Parameter(ParameterSetName="Tag")]
        [String]$Domain,

        [Parameter(ParameterSetName="ShortCode")]
        [Parameter(ParameterSetName="Tag")]
        [datetime]$StartDate,

        [Parameter(ParameterSetName="ShortCode")]
        [Parameter(ParameterSetName="Tag")]
        [datetime]$EndDate,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

    $Params = @{
        PropertyTree = @("visits")
    }

    switch -Regex ($PSCmdlet.ParameterSetName) {
        "Server" {
            $Params["Endpoint"] = "visits"
        }
        "ShortCode|Tag" {
            $Params["PropertyTree"] += "data"
            $Params["PSTypeName"] = "PSShlinkVisits"

            switch ($PSBoundParameters.Keys) {
                "Domain" {
                    $QueryString.Add("domain", $Domain)
                }
                "StartDate" {
                    $QueryString.Add("startDate", (Get-Date $StartDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                }
                "EndDate" {
                    $QueryString.Add("endDate", (Get-Date $EndDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                }
            }
        }
        "ShortCode" {
            $Params["Endpoint"] = "short-urls/{0}/visits" -f $ShortCode
        }
        "Tag" {
            $Params["Endpoint"] = "tags/{0}/visits" -f $Tag
        }
    }

    $Params["Query"] = $QueryString

    $Result = InvokeShlinkRestMethod @Params

    # I figured it would be nice to add the Server property so it is immediately clear 
    # the server's view count is returned when no parameters are used
    if ($PSCmdlet.ParameterSetName -eq "Server") {
        [PSCustomObject]@{
            Server      = $Script:ShlinkServer
            visitsCount = $Result.visitsCount
        }
    }
    else {
        $Result
    }
}