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
        }

        if ($WithStats.IsPresent) {
            $QueryString.Add("withStats", "true")
            $PropertyTree = @(
                $Params["ChildPropertyName"]
                "stats"
            )
        }
        else {
            $PropertyTree = @(
                $Params["ChildPropertyName"]
                "data"
            )
        }

        $Params["Query"] = $QueryString

        $Result = InvokeShlinkRestMethod @Params
        foreach ($Property in $PropertyTree) {
            $Result = $Result.$Property
        }
        Write-Output $Result
    }
    end {

    }
}