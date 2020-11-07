function New-ShlinkTag {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Tags,

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
            Endpoint = "tags"
            Method = "POST"
            Body = @{
                tags = @($Tags)
            }
            PropertyTree = @(
                "tags"
                "data"
            )
        }

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}