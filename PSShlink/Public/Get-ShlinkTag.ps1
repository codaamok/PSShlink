function Get-ShlinkTag {
    [CmdletBinding()]
    param (
        [Parameter()]
        [Switch]$WithStats,
        
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
            Endpoint = "tags"
            ChildPropertyName = "tags"
            PropertyTree = @("tags")
        }

        if ($WithStats.IsPresent) {
            $QueryString.Add("withStats", "true")
            $Params["PropertyTree"] += "stats"
        }
        else {
            $Params["PropertyTree"] += "data"
        }

        $Params["Query"] = $QueryString

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}