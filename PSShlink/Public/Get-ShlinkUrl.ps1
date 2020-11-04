function Get-ShlinkUrl {
    [CmdletBinding(DefaultParameterSetName="ListShortUrls")]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey,

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
        [datetime]$EndDate,

        [Parameter(Mandatory, ParameterSetName="ParseShortCode")]
        [String]$ShortCode,

        [Parameter(ParameterSetName="ParseShortCode")]
        [String]$Domain
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
                switch ($PSBoundParameters.Keys) {
                    "ShortCode" {
                        $Params["Path"] = $ShortCode
                    }
                    "Domain" {
                        $QueryString.Add("domain", $Domain)
                    }
                }
            }
            "ListShortUrls" {
                $Params["ChildPropertyName"] = "shortUrls"

                $Params["PropertyTree"] = @(
                    "shortUrls"
                    "data"
                )

                switch ($PSBoundParameters.Keys) {
                    "Tags" {
                        foreach ($Tag in $Tags) {
                            $QueryString.Add("tags[]", $Tag)
                        }
                    }
                    "SearchTerm" {
                        $QueryString.Add("searchTerm", $SearchTerm)
                    }
                    "OrderBy" {
                        $QueryString.Add("orderBy", $OrderBy)
                    }
                    "StartDate" {
                        $QueryString.Add("startDate", (Get-Date $StartDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                    }
                    "EndDate" {
                        $QueryString.Add("endDate", (Get-Date $EndDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                    }
                }
            }
        }

        $Params["Query"] = $QueryString

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}