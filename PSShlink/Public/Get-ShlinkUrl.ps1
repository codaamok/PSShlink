function Get-ShlinkUrl {
    [CmdletBinding(DefaultParameterSetName="ListShortUrls")]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey,

        [Parameter(ParameterSetName="ParseShortCode")]
        [String]$ShortCode,

        [Parameter(ParameterSetName="ParseShortCode")]
        [String]$Domain,

        [Parameter(ParameterSetName="ListShortUrls")]
        [String]$SearchTerm,

        [Parameter(ParameterSetName="ListShortUrls")]
        [String[]]$Tags,

        [Parameter(ParameterSetName="ListShortUrls")]
        [ValidateSet("longUrl", "shortCode", "dateCreated", "visits")]
        [String]$OrderBy,

        [Parameter(ParameterSetName="ListShortUrls")]
        [datetime]$StartDate,

        [Parameter(ParameterSetName="ListShortUrls")]
        [datetime]$EndDate
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $Params = @{
            Endpoint = "short-urls"
        }

        switch ($PSCmdlet.ParameterSetName) {
            "ParseShortCode" {
                if ($ShortCode) {
                    $Params["Path"] = $ShortCode
                }

                if ($Domain) {
                    $QueryString.Add("domain", $Domain)
                    $Params["Query"] = $QueryString
                }
            }
            "ListShortUrls" {
                $Params["ChildPropertyName"] = "shortUrls"

                foreach ($Tag in $Tags) {
                    $QueryString.Add("tags[]", $Tag)
                    $Params["Query"] = $QueryString
                }
            }
        }

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}