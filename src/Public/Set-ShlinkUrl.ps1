function Set-ShlinkUrl {
    <#
    .SYNOPSIS
        Update an existing short code on the Shlink server.
    .DESCRIPTION
        Update an existing short code on the Shlink server.
    .PARAMETER ShortCode
        The name of the short code you wish to update.
    .PARAMETER LongUrl
        The new long URL to associate with the existing short code.
    .PARAMETER AndroidLongUrl
        The long URL to redirect to when the short URL is visited from a device running Android.
    .PARAMETER IOSLongUrl
        The long URL to redirect to when the short URL is visited from a device running iOS.
    .PARAMETER DesktopLongUrl
        The long URL to redirect to when the short URL is visited from a desktop browser.
    .PARAMETER Tags
        The name of one or more tags to associate with the existing short code.
        Due to the architecture of Shlink's REST API, this parameter can only be used in its own parameter set.
    .PARAMETER ValidSince
        Define a new "valid since" date with the existing short code.
    .PARAMETER ValidUntil
        Define a new "valid until" date with the existing short code.
    .PARAMETER MaxVisits
        Set a new maximum visits threshold for the existing short code.
    .PARAMETER Domain
        The domain which is associated with the short code you wish to update.
        This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .PARAMETER Title
        Define a title with the new short code.
    .PARAMETER ValidateUrl
        Control long URL validation while creating the short code.
    .PARAMETER ForwardQuery
        Forwards UTM query parameters to the long URL if any were passed to the short URL.
    .PARAMETER Crawlable
        Set short URLs as crawlable, making them be listed in the robots.txt as Allowed.    
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Set-ShlinkUrl -ShortCode "profile" -LongUrl "https://github.com/codaamok" -ValidSince (Get-Date "2020-11-01") -ValidUntil (Get-Date "2020-11-30") -MaxVisits 99
        
        Update the existing short code "profile", associated with the default domain of the Shlink server, to point to URL "https://github.com/codaamok". The link will only be valid for November 2020. The link will only work for 99 visits. 
    .EXAMPLE
        PS C:\> Set-ShlinkUrl -ShortCode "profile" -Tags "powershell","pwsh"

        Update the existing short code "profile" to have the tags "powershell" and "pwsh" associated with it.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -SearchTerm "preview" | Set-ShlinkUrl -Tags "preview"

        Updates all existing short codes which match the search term "preview" to have the tag "preview".
    .INPUTS
        System.String[]

        Used for the -ShortCode parameter.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]]$ShortCode,

        [Parameter()]
        [String]$LongUrl,

        [Parameter()]
        [String]$AndroidLongUrl,

        [Parameter()]
        [String]$IOSLongUrl,

        [Parameter()]
        [String]$DesktopLongUrl,

        [Parameter()]
        [String[]]$Tags,

        [Parameter()]
        [datetime]$ValidSince,

        [Parameter()]
        [datetime]$ValidUntil,

        [Parameter()]
        [Int]$MaxVisits,

        [Parameter()]
        [String]$Title,

        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Domain,

        [Parameter()]
        [Bool]$ValidateUrl,

        [Parameter()]
        [Bool]$ForwardQuery,

        [Parameter()]
        [Bool]$Crawlable,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        try {
            GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction "Stop"
        }
    }
    process {
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

        $Params = @{
            Endpoint = "short-urls"
            Method = "PATCH"
            Body = @{}
        }

        foreach ($Code in $ShortCode) {
            $Params["Path"] = $Code

            $deviceLongUrls = @{}

            switch($PSBoundParameters.Keys) {
                "AndroidLongUrl" {
                    $deviceLongUrls["android"] = $AndroidLongUrl
                    $Params["Body"]["deviceLongUrls"] = $deviceLongUrls
                }
                "IOSLongUrl" {
                    $deviceLongUrls["ios"] = $IOSLongUrl
                    $Params["Body"]["deviceLongUrls"] = $deviceLongUrls
                }
                "DesktopLongUrl" {
                    $deviceLongUrls["desktop"] = $DesktopLongUrl
                    $Params["Body"]["deviceLongUrls"] = $deviceLongUrls
                }
                "LongUrl" {
                    $Params["Body"]["longUrl"] = $LongUrl
                }
                "Tags" {
                    $Params["Body"]["tags"] = @($Tags)
                }
                "ValidSince" {
                    $Params["Body"]["validSince"] = Get-Date $ValidSince -Format "yyyy-MM-ddTHH:mm:sszzzz"
                }
                "ValidUntil" {
                    $Params["Body"]["validUntil"] = Get-Date $ValidUntil -Format "yyyy-MM-ddTHH:mm:sszzzz"
                }
                "MaxVisits" {
                    $Params["Body"]["maxVisits"] = $MaxVisits
                }
                "Title" {
                    $Params["Body"]["title"] = $Title
                }
                "Domain" {
                    # An additional null check here, and not as a validate parameter attribute, because I wanted it to be simple
                    # to pipe to Set-ShlinkUrl where some objects have a populated, or null, domain property. 
                    # The domain property is blank for short codes if they were created to use the Shlink instance's default domain. 
                    # They are also most commonly blank on Shlink instances where there are no additional domains responding / listening. 
                    if (-not [String]::IsNullOrWhiteSpace($Domain)) {
                        $QueryString.Add("domain", $Domain)
                    }
                }
                "ValidateUrl" {
                    Write-Warning 'validateUrl is deprecated since Shlink 3.5.0'
                    $Params["Body"]["validateUrl"] = $ValidateUrl
                }
                "ForwardQuery" {
                    $Params["Body"]["forwardQuery"] = $ForwardQuery
                }
                "Crawlable" {
                    $Params["Body"]["crawlable"] = $Crawlable
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
    }
    end {
    }
}