function InvokeRestMethod {
    param (
        [Parameter()]
        [String]$Server = $Script:ShlinkServer,

        [Parameter()]
        [SecureString]$ApiKey = $Script:ShlinkApiKey,

        [Parameter()]
        [String]$Endpoint,

        [Parameter()]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'GET',

        [Parameter()]
        [String]$Parameter,

        [Parameter()]
        [hashtable]$Query
    )
    begin {
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ApiKey)
    }
    process {
        $Params = @{
            Method = $Method
            Uri = "{0}/rest/v2/{1}" -f $Server, $Endpoint
            ContentType = "application/json"
            Headers = @{"X-Api-Key" = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)}
        }

        if ($PSBoundParameters.ContainsKey("Parameter")) {
            $Params["Uri"] = "{0}/{1}" -f $Params["Uri"], $Parameter
        }

        if ($PSBoundParameters.ContainsKey("Query")) {
            $Params["Body"] = $Query
        }

        Invoke-RestMethod @Params
    }
    end {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}