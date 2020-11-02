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

        # Default value set where no Query parameter is passed because we still need the object for pagination later
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

            $PaginationData = if ($ChildPropertyName) {
                Write-Output $Data.$ChildPropertyName.pagination
            }
            else {
                Write-Output $Data.pagination
            }
            
            if ($PaginationData) {
                $Query["page"] = $PaginationData.currentPage + 1
                $Params["Uri"] = "{0}?{1}" -f $QuerylessUri, $Query.ToString()
            }

            Write-Output $Data
        } while ($PaginationData.currentPage -ne $PaginationData.pagesCount -And $PaginationData.pagesCount -ne 0)
        # TODO: Why is this loop not breaking out when PaginationData.currentPage is 0? (when no result was found and response was http 200)
        
        # A "data" child property only exists when $ChildPropertyName is defined
        if ($ChildPropertyName) {
            Write-Output $Result.$ChildPropertyName.data
        }
        else {
            Write-Output $Result
        }
    }
    end {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}