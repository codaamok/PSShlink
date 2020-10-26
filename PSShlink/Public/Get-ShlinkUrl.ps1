function Get-ShlinkUrl {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShortCode,

        [Parameter()]
        [String]$Domain,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey        
    }
    process {
        $Params = @{
            Endpoint = "short-urls"
        }

        if ($PSBoundParameters.ContainsKey("ShortCode")) {
            $Params["Parameter"] = $ShortCode
        }

        if ($PSBoundParameters.ContainsKey("Domain")) {
            $Params["Query"] = @{
                domain = $Domain
            }
        }

        InvokeRestMethod @Params
    }
    end {
    }
}