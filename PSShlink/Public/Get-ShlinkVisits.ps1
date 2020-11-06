function Get-ShlinkVists {
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
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $Params = @{
            PropertyTree = @("visits")
        }

        switch -Regex ($PSCmdlet.ParameterSetName) {
            "Server" {
                $Params["Endpoint"] = "visits"
            }
            "ShortCode|Tag" {
                $Params["PropertyTree"] += "data"

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
                Server = $Script:ShlinkServer
                visitsCount = $Result.visitsCount
            }
        }
        else {
            $Result
        }
    }
    end {
    }
}