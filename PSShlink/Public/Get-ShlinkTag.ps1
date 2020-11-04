function Get-ShlinkTag {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey,

        [Parameter()]
        [Switch]$WithStats
        
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