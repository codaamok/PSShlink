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
        [String[]]$PropertyTree,

        [Parameter()]
        [Int]$Page,

        [Parameter()]
        [String]$PSTypeName
    )

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ApiKey)

    $Params = @{
        Method        = $Method
        Uri           = "{0}/rest/v2/{1}" -f $Server, $Endpoint
        ContentType   = "application/json"
        Headers       = @{"X-Api-Key" = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)}
        ErrorAction   = "Stop"
        ErrorVariable = "InvokeRestMethodError"
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
        try {
            Write-Verbose ("Body: {0}" -f $Params["Body"])
            $Data = Invoke-RestMethod @Params
        }
        catch {
            # The web exception class is different for Core vs Windows
            if ($InvokeRestMethodError.ErrorRecord.Exception.GetType().FullName -match "HttpResponseException|WebException") {
                $ExceptionMessage = $InvokeRestMethodError.Message | ConvertFrom-Json | Select-Object -ExpandProperty detail
                $ErrorId = "{0}{1}" -f 
                    [Int][System.Net.HttpStatusCode]$InvokeRestMethodError.ErrorRecord.Exception.Response.StatusCode, 
                    [String][System.Net.HttpStatusCode]$InvokeRestMethodError.ErrorRecord.Exception.Response.StatusCode

                switch -Regex ($InvokeRestMethodError.ErrorRecord.Exception.Response.StatusCode) {
                    "BadRequest|Conflict" {
                        $Exception = [System.ArgumentException]::new($ExceptionMessage)
                        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                            $Exception,
                            $ErrorId,
                            [System.Management.Automation.ErrorCategory]::InvalidArgument,
                            $Params['Url']
                        )
                    }
                    "NotFound" {
                        $Exception = [System.Management.Automation.ItemNotFoundException]::new($ExceptionMessage)
                        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                            $Exception,
                            $ErrorId,
                            [System.Management.Automation.ErrorCategory]::ObjectNotFound,
                            $Params['Uri']
                        )
                    }
                    "ServiceUnavailable" {
                        $Exception = [System.InvalidOperationException]::new($ExceptionMessage)
                        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                            $Exception,
                            $ErrorId,
                            [System.Management.Automation.ErrorCategory]::ResourceUnavailable,
                            $Params['Uri']
                        )
                    }
                    default {
                        $Exception = [System.InvalidOperationException]::new($ExceptionMessage)
                        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                            $Exception,
                            $ErrorId,
                            [System.Management.Automation.ErrorCategory]::InvalidOperation,
                            $Params['Uri']
                        )
                    }
                }
    
                $PSCmdlet.ThrowTerminatingError($ErrorRecord)
            }
            else {
                $PSCmdlet.ThrowTerminatingError($_)
            }   
        }

        $PaginationData = if ($PropertyTree) {
            Write-Output $Data.($PropertyTree[0]).pagination
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

    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
}