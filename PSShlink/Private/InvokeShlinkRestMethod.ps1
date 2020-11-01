function InvokeShlinkRestMethod {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$Server = $Script:ShlinkServer,

        [Parameter()]
        [SecureString]$ApiKey = $Script:ShlinkApiKey,

        [Parameter()]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'GET',

        [Parameter(Mandatory)]
        [String]$Endpoint,

        [Parameter()]
        [String]$Path,

        [Parameter()]
        [System.Collections.Specialized.NameValueCollection]$Query = [System.Web.HttpUtility]::ParseQueryString(''),

        [Parameter()]
        [String]$ChildPropertyName,

        [Parameter()]
        [Int]$Page
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

        if ($PSBoundParameters.ContainsKey("Path")) {
            $Params["Uri"] = "{0}/{1}" -f $Params["Uri"], $Path
        }

        # Preserve the URI which does not contain any query parameters for the pagination URI building later
        $QuerylessUri = $Params["Uri"]

        if ($PSBoundParameters.ContainsKey("Query")) {
            $Params["Uri"] = "{0}?{1}" -f $Params["Uri"], $Query.ToString()
        }

        $Result = do {
            $Data = Invoke-RestMethod @Params
            $PaginationData = GetPaginationData -Object $Data -ChildPropertyName $ChildPropertyName
            if ($PaginationData) {
                $Query["page"] = $PaginationData.currentPage + 1
                $Params["Uri"] = "{0}?{1}" -f $QuerylessUri, $Query.ToString()
            }
        } while ($PaginationData.currentPage -ne $PaginationData.pagesCount -Or "None" -ne $PaginationData)
        # TODO: I was working out the pagination handling. Can't quite work out how to the loop
        # where there is no pagination data returned in the API call
        
        if ($ChildPropertyName) {
            $Result.$ChildPropertyName.data
        }
        else {
            $Result
        }
        
    }
    end {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}