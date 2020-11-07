function Remove-ShlinkUrl {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
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
            Path = $ShortCode
            Method = "DELETE"
        }

        $WouldMessage = "Would delete short code '{0}' from Shlink server '{1}'" -f $ShortCode, $Script:ShlinkServer
        $RemovingMessage = "Removing short code '{0}' from Shlink server '{1}'" -f $ShortCode, $Script:ShlinkServer
        
        switch ($PSBoundParameters.Keys) {
            "Domain" {
                $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
                $QueryString.Add("domain", $Domain)
                $Params["Query"] = $QueryString
                
                $WouldMessage = $WouldMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
                $RemovingMessage = $RemovingMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
            }
        }

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