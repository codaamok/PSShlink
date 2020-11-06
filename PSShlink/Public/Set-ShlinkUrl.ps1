function Set-ShlinkUrl {
    [CmdletBinding(DefaultParameterSetName="EditUrl")]
    param (
        [Parameter(Mandatory, ParameterSetName="EditUrlTag")]
        [Parameter(Mandatory, ParameterSetName="EditUrl")]
        [String]$ShortCode,

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
        switch ($PSCmdlet.ParameterSetName) {
            "EditUrl" {
                $Params = @{
                    Endpoint = "short-urls"
                    Path = $ShortCode
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
                    "Domain" {
                        $QueryString.Add("domain", $Domain)
                    }
                }
            }
            "EditUrlTag" {
                $Params = @{
                    Endpoint = "short-urls/{0}/tags" -f $ShortCode
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
        }

        $Params["Query"] = $QueryString

        # Note: when using -Tags the API endpoint returns a successful message / object,
        # whereas with everything else no success message / object is returned.
        InvokeShlinkRestMethod @Params
    }
    end {
    }
}