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
    [CmdletBinding(DefaultParameterSetName="EditUrl")]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName="EditUrlTag")]
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName="EditUrl")]
        [String[]]$ShortCode,

        [Parameter(Mandatory, ParameterSetName="EditUrl")]
        [String]$LongUrl,

        [Parameter(Mandatory, ParameterSetName="EditUrlTag")]
        [String[]]$Tags,

        [Parameter(ParameterSetName="EditUrl")]
        [datetime]$ValidSince,

        [Parameter(ParameterSetName="EditUrl")]
        [datetime]$ValidUntil,

        [Parameter(ParameterSetName="EditUrl")]
        [Int]$MaxVisits,

        [Parameter(ParameterSetName="EditUrlTag")]
        [Parameter(ParameterSetName="EditUrl")]
        [String]$Domain,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        foreach ($Code in $ShortCode) {
            $GetShlinkUrlParams = @{
                ShortCode = $Code
            }

            switch ($PSCmdlet.ParameterSetName) {
                "EditUrl" {
                    $Params = @{
                        Endpoint = "short-urls"
                        Path = $Code
                        Method = "PATCH"
                        Body = @{
                            longUrl = $LongUrl
                        }
                    }

                    switch ($PSBoundParameters.Keys) {
                        "ValidSince" {
                            $Params["Body"]["validSince"] = (Get-Date $ValidSince -Format "yyyy-MM-ddTHH:mm:sszzzz")
                        }
                        "ValidUntil" {
                            $Params["Body"]["validUntil"] = (Get-Date $ValidSince -Format "yyyy-MM-ddTHH:mm:sszzzz")
                        }
                        "MaxVisits" {
                            $Params["Body"]["maxVisits"] = $MaxVisits
                        }
                    }
                }
                "EditUrlTag" {
                    $Params = @{
                        Endpoint = "short-urls/{0}/tags" -f $Code
                        Method = "PUT"
                        Query = $QueryString
                        Body = @{
                            tags = @($Tags)
                        }
                    }
                }
            }

            # The Domain parameter can be used in both parameter sets
            if ($PSBoundParameters.ContainsKey("Domain")) {
                $QueryString.Add("domain", $Domain)
                $GetShlinkUrlParams["Domain"] = $Domain
            }

            $Params["Query"] = $QueryString

            try {
                # Note: when using -Tags the API endpoint returns a successful message / object,
                # whereas with everything else no success message / object is returned...
                $null = InvokeShlinkRestMethod @Params

                # ... as a result I want to create a user experience where another call is made
                # to Get-ShlinkUrl to show the user their new changes, viewing the whole object
                # for each short code.
                Get-ShlinkUrl @GetShlinkUrlParams
            }
            catch {
                Write-Error -ErrorRecord $_
            }
        }
    }
    end {
    }
}