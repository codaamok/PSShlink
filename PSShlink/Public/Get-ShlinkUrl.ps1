function Get-ShlinkUrl {
    <#
    .SYNOPSIS
        Get details of all short codes, or just one.
    .DESCRIPTION
        Get details of all short codes, or just one. Various filtering options are available from the API to ambigiously search for short codes.
    .PARAMETER ShortCode
        The name of the short code you wish to search for. For example, if the short URL is "https://example.com/new-url" then the short code is "new-url".
    .PARAMETER Domain
        The domain (excluding schema) associated with the short code you wish to search for. For example, "example.com" is an acceptable value. 
        This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .PARAMETER SearchTerm
        The search term to search for a short code with.
    .PARAMETER Tags
        One or more tags can be passed to find short codes using said tag(s).
    .PARAMETER OrderBy
        Order the results returned by "longUrl", "shortCode", "dateCreated", or "visits". The default sort order is in ascending order.
    .PARAMETER StartDate
        A datetime object to search for short codes where its start date is equal or greater than this value. 
        If a start date is not configured for the short code(s), this filters on the dateCreated property.
    .PARAMETER EndDate
        A datetime object to search for short codes where its end date is equal or less than this value. 
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl
        
        Returns all short codes with no filtering applied.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -ShortCode "profile"

        Returns the short code "profile".
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -ShortCode "profile" -Domain "example.com"

        Returns the short code "profile" using the domain "example.com". This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -Tags "oldwebsite", "evenolderwebsite" -OrderBy "dateCreated"

        Returns short codes which are associated with the tags "oldwebsite" and "evenolderwebsite". Ordered by the dateCreated property in ascending order.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -StartDate (Get-Date "2020-10-25 11:00:00")

        Returns short codes which have a start date of 25th October 2020 11:00:00 AM or newer. If a start date was not configured for the short code(s), this filters on the dateCreated property.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -SearchTerm "microsoft"

        Returns the short codes which match the search term "microsoft".
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject

        Objects have a PSTypeName of 'PSTypeName'.
    #>
    [CmdletBinding(DefaultParameterSetName="ListShortUrls")]
    param (
        [Parameter(Mandatory, ParameterSetName="ParseShortCode")]
        [String]$ShortCode,

        [Parameter(ParameterSetName="ParseShortCode")]
        [String]$Domain,

        [Parameter(ParameterSetName="ListShortUrls")]
        [String]$SearchTerm,

        [Parameter(ParameterSetName="ListShortUrls")]
        [String[]]$Tags,

        [Parameter(ParameterSetName="ListShortUrls")]
        [ValidateSet("longUrl", "shortCode", "dateCreated", "visits")]
        [String]$OrderBy,

        [Parameter(ParameterSetName="ListShortUrls")]
        [datetime]$StartDate,

        [Parameter(ParameterSetName="ListShortUrls")]
        [datetime]$EndDate,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    # Using begin / process / end blocks due to the way PowerShell processes all 
    # begin blocks in the pipeline first before the process blocks. If user passed
    # -ShlinkServer and -ShlinkApiKey in this function and piped to something else,
    # e.g. Set-ShlinkUrl, and they omitted those parameters from the piped function, 
    # they will be prompted for -ShlinkServer and -ShlinkApiKey. This is not my intended
    # user experience. Hence the decision to implement begin/process/end blocks here.
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $Params = @{
            Endpoint      = "short-urls"
            PSTypeName    = "PSShlink"
        }
    
        switch ($PSCmdlet.ParameterSetName) {
            "ParseShortCode" {
                switch ($PSBoundParameters.Keys) {
                    "ShortCode" {
                        $Params["Path"] = $ShortCode
                    }
                    "Domain" {
                        $QueryString.Add("domain", $Domain)
                    }
                }
            }
            "ListShortUrls" {
                $Params["ChildPropertyName"] = "shortUrls"
    
                $Params["PropertyTree"] = @(
                    "shortUrls"
                    "data"
                )
    
                switch ($PSBoundParameters.Keys) {
                    "Tags" {
                        foreach ($Tag in $Tags) {
                            $QueryString.Add("tags[]", $Tag)
                        }
                    }
                    "SearchTerm" {
                        $QueryString.Add("searchTerm", $SearchTerm)
                    }
                    "OrderBy" {
                        $QueryString.Add("orderBy", $OrderBy)
                    }
                    "StartDate" {
                        $QueryString.Add("startDate", (Get-Date $StartDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                    }
                    "EndDate" {
                        $QueryString.Add("endDate", (Get-Date $EndDate -Format "yyyy-MM-ddTHH:mm:sszzzz"))
                    }
                }
            }
        }
    
        $Params["Query"] = $QueryString
        
        try {
            InvokeShlinkRestMethod @Params
        }
        catch {
            Write-Error -ErrorRecord $_
        }
    }
    end {
    }    
}