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
        [String[]]$Tags,

        [Parameter()]
        [datetime]$ValidSince,

        [Parameter()]
        [datetime]$ValidUntil,

        [Parameter()]
        [Int]$MaxVisits,

        [Parameter()]
        [String]$Title,

        [Parameter()]
        [String]$Domain,

        [Parameter()]
        [Switch]$DoNotValidateUrl,

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
        
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

        $Params = @{
            Endpoint = "short-urls"
            Method = "PATCH"
            Body = @{}
        }
    }
    process {
        foreach ($Code in $ShortCode) {
            $Params["Path"] = $Code

            switch($PSBoundParameters.Keys) {
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
                    $QueryString.Add("domain", $Domain)
                }
                "DoNotValidateUrl" {
                    $Params["Body"]["validateUrl"] = -not $DoNotValidateUrl.IsPresent
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