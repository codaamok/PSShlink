function New-ShlinkUrl {
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
            Method = "POST"
            Body = @{
                longUrl = $LongUrl
            }
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

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}