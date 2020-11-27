function New-ShlinkUrl {
    <#
    .SYNOPSIS
        Creates a new Shlink short code on your Shlink server.
    .DESCRIPTION
        Creates a new Shlink short code on your Shlink server.
    .PARAMETER LongUrl
        Define the long URL for the new short code.
    .PARAMETER CustomSlug
        Define a custom slug for the new short code.
    .PARAMETER Tags
        Associate tag(s) with the new short code.
    .PARAMETER ValidSince
        Define a "valid since" date with the new short code.
    .PARAMETER ValidUntil
        Define a "valid until" date with the new short code.
    .PARAMETER MaxVisits
        Set the maximum number of visits allowed for the new short code.
    .PARAMETER Domain
        Associate a domain with the new short code to be something other than the default domain. 
        This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .PARAMETER ShortCodeLength
        Set the length of your new short code other than the default.
    .PARAMETER FindIfExists
        Specify this switch to first search and return the data about an existing short code that uses the same long URL if one exists.
    .PARAMETER DoNotValidateUrl
        Disables long URL validation while creating the short code.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> New-ShlinkUrl -LongUrl "https://google.com"
        
        Will generate a new short code with the long URL of "https://google.com", using your Shlink server's default for creating new short codes, and return all the information about the new short code.
    .EXAMPLE
        PS C:\> New-ShlinkUrl -LongUrl "https://google.com" -CustomSlug "mygoogle" -Tags "search-engine" -ValidSince (Get-Date "2020-11-01") -ValidUntil (Get-Date "2020-11-30") -MaxVisits 99 -FindIfExists
    
        Will generate a new short code with the long URL of "https://google.com" using the custom slug "search-engine". The default domain for the Shlink server will be used. The link will only be valid for November 2020. The link will only work for 99 visits. If a duplicate short code is found using the same long URL, another is not made and instead data about the existing short code is returned.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$LongUrl,

        [Parameter()]
        [String]$CustomSlug,

        [Parameter()]
        [String[]]$Tags,

        [Parameter()]
        [datetime]$ValidSince,

        [Parameter()]
        [datetime]$ValidUntil,

        [Parameter()]
        [Int]$MaxVisits,

        [Parameter()]
        [String]$Domain,

        [Parameter()]
        [Int]$ShortCodeLength,

        [Parameter()]
        [Switch]$FindIfExists,

        [Parameter()]
        [Switch]$DoNotValidateUrl,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey

    $Params = @{
        Endpoint    = "short-urls"
        Method      = "POST"
        Body        = @{
            longUrl     = $LongUrl
            validateUrl = (-not $DoNotValidateUrl.IsPresent).ToString().ToLower()
        }
        ErrorAction = "STop"
    }

    switch ($PSBoundParameters.Keys) {
        "CustomSlug" {
            $Params["Body"]["customSlug"] = $CustomSlug
        }
        "Tags" {
            $Params["Body"]["tags"] = @($Tags)
        }
        "ValidSince" {
            $Params["Body"]["validSince"] = (Get-Date $ValidSince -Format "yyyy-MM-ddTHH:mm:sszzzz")
        }
        "ValidUntil" {
            $Params["Body"]["validUntil"] = (Get-Date $ValidSince -Format "yyyy-MM-ddTHH:mm:sszzzz")
        }
        "MaxVisits" {
            $Params["Body"]["maxVisits"] = $MaxVisits
        }
        "Domain" {
            $Params["Body"]["domain"] = $Domain
        }
        "ShortCodeLength" {
            $Params["Body"]["shortCodeLength"] = $ShortCodeLength
        }
        "FindIfExists" {
            $Params["Body"]["findIfExists"] = "true"
        }
    }

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}