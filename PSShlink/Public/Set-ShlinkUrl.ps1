function Set-ShlinkUrl {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey,

        [Parameter(Mandatory)]
        [String]$ShortCode,

        [Parameter(Mandatory)]
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
        [String]$Domain
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
        $TagsQueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $Params = @{
            Endpoint = "short-urls"
            Path = $ShortCode
            Method = "PATCH"
            Body = @{
                longUrl = $LongUrl
            }
        }

        switch -Regex ($PSBoundParameters.Keys) {
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
                # Note: this is still defined if -Tags parameter is not passed
                $TagsQueryString.Add("domain", $Domain)
            }
            "Tags" {
                $TagsParams = @{
                    Endpoint = "{0}/{1}/tags" -f $Params["Endpoint"], $Params["Path"]
                    Method = "PUT"
                    Query = $TagsQueryString
                    Body = @{
                        tags = @($Tags)
                    }
                }
            }
        }

        $Params["Query"] = $QueryString
        
        # TODO: This was a waste of time. I need to create Set-ShlinkUrlTags
        # because otherwise -LongUrl is mandatory when all the user wants to change
        # is a short code's tags. longUrl is not a parameter for the API if just modifying tags.
        foreach ($item in $Params,$TagsParams) {
            # Only the /tags call returns an object, whereas the other does not.
            # Therefore to be consistent and reduce confusion, I figured it would make sense
            # to throw away the output otherwise I would need to create a success result 
            # message / object for the user and also do the same in other functions which also 
            # do not natively return a success result message / object e.g. Remove-ShlinkUrl
            $null = InvokeShlinkRestMethod @item
        }
    }
    end {
    }
}