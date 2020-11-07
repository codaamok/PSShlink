function Remove-ShlinkTag {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
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
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        foreach ($Tag in $Tags) {
            $QueryString.Add("tags[]", $Tag)
        }

        $Params = @{
            Endpoint = "tags"
            Method = "DELETE"
            Query = $QueryString
        }

        if ($PSCmdlet.ShouldProcess(
            ("Would delete tag(s) '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $ShlinkServer),
            "Are you sure you want to continue?",
            ("Removing tag(s) '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $ShlinkServer))) {
                InvokeShlinkRestMethod @Params
            }
    }
    end {
    }
}