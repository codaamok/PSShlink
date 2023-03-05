function Invoke-ShlinkRestMethod {
    # TODO this function needs tests
    <#
    .SYNOPSIS
        Query a Shlink server's REST API
    .DESCRIPTION
        This function provides flexibility to query a Shlink's server how you want to. 
        
        Specify all the parameters, endpoint, and path details you need.

        All data from all pages are returned.

        See Shlink's REST API documentation: https://shlink.io/documentation/api-docs/ and https://api-spec.shlink.io/
    .PARAMETER Endpoint
        The endpoint to use in the request. This is before the -Path. See the examples for example usage.
    .PARAMETER Path
        The path to use in the request. This is after the -Endpoint. See the examples for example usage.
    .PARAMETER Query
        The query to use in the request. Must be an instance of System.Web.HttpUtility. See the examples for example usage.

        Note (it's not obvious), you can add more query params to an instance of HttpUtility like you can any dictionary by using the .Add() method on the object.
    .PARAMETER ApiVersion
        The API version of Shlink to use in the request.
    .PARAMETER Method
        The HTTP method to use in the request.
    .PARAMETER PropertyTree
        Data returned by Shlink's rest API is usually embedded within one or two properties.
        
        Here you can specify the embedded properties as a string array in the order you need to select them to access the data.

        For example, the "short-urls" endpoint includes the data within the "shortUrls.data" properties. Therefore, for this parameter you specify a string array of @("shortUrls", "data").

        In other words, using this function for the short-urls endpoint results in the below object if there are two pages worth of data returned:

            Invoke-ShlinkRestMethod -Endpoint 'short-urls'

            shortUrls
            ---------
            @{data=System.Object[]; pagination=}
            @{data=System.Object[]; pagination=}
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        Invoke-ShlinkRestMethod -Endpoint "short-urls" -PropertyTree "shortUrls", "Data" -Query [System.Web.HttpUtility]::ParseQueryString("searchTerm", "abc")

        Gets all short codes from Shlink matching the search term "abc".

        Note (it's not obvious), you can add more query params to an instance of HttpUtility like you can any dictionary by using the .Add() method on the object.
    .EXAMPLE
        Invoke-ShlinkRestMethod -Endpoint "short-urls" -Path "abc" -METHOD "DELETE"

        Deletes the shortcode "abc" from Shlink.
    .EXAMPLE
        Invoke-ShlinkRestMethod -Endpoint "tags" -Path "stats"

        Gets all tags with statistics.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$Endpoint,

        [Parameter()]
        [String]$Path,

        # Default value set where no Query parameter is passed because we still need the object for pagination later
        [Parameter()]
        [System.Web.HttpUtility]$Query,

        [Parameter()]
        [ValidateSet(1, 2, 3)]
        [Int]$ApiVersion = 3,

        [Parameter()]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'GET',

        [Parameter()]
        [String[]]$PropertyTree,

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

    $Params = @{
        Endpoint = $Endpoint
        Method   = $Method
    }

    switch ($PSBoundParameters.Keys) {
        "Path" {
            $Params["Path"] = $Path
        }
        "Query" {
            $Params["Query"] = $Query
        }
        "ApiVersion" {
            $Params["ApiVersion"] = $ApiVersion
        }
        "PropertyTree" {
            $Params["PropertyTree"] = $PropertyTree
        }
    }

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}