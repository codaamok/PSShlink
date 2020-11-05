function Remove-ShlinkUrl {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey,

        [Parameter(Mandatory)]
        [String]$ShortCode,

        [Parameter()]
        [String]$Domain
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $Params = @{
            Endpoint = "short-urls"
            Path = $ShortCode
            Method = "DELETE"
        }

        $WouldMessage = "Would delete short code '{0}' from Shlink server '{1}'" -f $ShortCode, $Script:ShlinkServer
        $RemovingMessage = "Removing short code '{0}' from Shlink server '{1}'" -f $ShortCode, $Script:ShlinkServer
        
        switch ($PSBoundParameters.Keys) {
            "Domain" {
                $QueryString.Add("domain", $Domain)
                $WouldMessage = $WouldMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
                $RemovingMessage = $RemovingMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
            }
        }

        $Params["Query"] = $QueryString

        if ($PSCmdlet.ShouldProcess(
            $WouldMessage,
            "Are you sure you want to continue?",
            $RemovingMessage)) {
                InvokeShlinkRestMethod @Params
        }
    }
    end {
    }
}