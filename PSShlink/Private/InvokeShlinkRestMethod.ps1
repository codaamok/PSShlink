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
        [hashtable]$Body,

        [Parameter()]
        [String]$ChildPropertyName,

        [Parameter()]
        [String[]]$PropertyTree,

        [Parameter()]
        [Int]$Page,

        [Parameter()]
        [String]$PSTypeName
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

        if ($PSBoundParameters.ContainsKey("Body")) {
            $Params["Body"] = $Body | ConvertTo-Json
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
    
        # Walk down the object's properties to return the desired property
        # e.g. sometimes the data is burried in tags.data or shortUrls.data etc
        foreach ($Property in $PropertyTree) {
            $Result = $Result.$Property
        }

        if ($PSBoundParameters.ContainsKey("PSTypeName")) {
            foreach ($item in $Result) {
                $item.PSTypeNames.Insert(0, $PSTypeName)
            }
        }

        Write-Output $Result
    }
    end {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    }
}