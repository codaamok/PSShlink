function Remove-ShlinkUrl {
    <#
    .SYNOPSIS
        Removes a short code from the Shlink server
    .DESCRIPTION
        Removes a short code from the Shlink server
    .PARAMETER ShortCode
        The name of the short code you wish to remove from the Shlink server.
    .PARAMETER Domain
        The domain associated with the short code you wish to remove from the Shlink server.
        This is useful if your Shlink instance is responding/creating short URLs for multiple domains.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Remove-ShlinkUrl -ShortCode "profile" -WhatIf
        
        Reports what would happen if the command was invoked, because the -WhatIf parameter is present.
    .EXAMPLE
        PS C:\> Remove-ShlinkUrl -ShortCode "profile" -Domain "example.com"

        Removes the short code "profile" associated with the domain "example.com" from the Shlink server.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -SearchTerm "oldwebsite" | Remove-ShlinkUrl

        Removes all existing short codes which match the search term "oldwebsite".
    .EXAMPLE
        PS C:\> "profile", "house" | Remove-ShlinkUrl

        Removes the short codes "profile" and "house" from the Shlink instance.
    .INPUTS
        System.String[]

        Used for the -ShortCode parameter.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]]$ShortCode,

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
        foreach ($Code in $ShortCode) {
            $Params = @{
                Endpoint    = "short-urls"
                Path        = $Code
                Method      = "DELETE"
                ErrorAction = "Stop"
            }

            $WouldMessage = "Would delete short code '{0}' from Shlink server '{1}'" -f $Code, $Script:ShlinkServer
            $RemovingMessage = "Removing short code '{0}' from Shlink server '{1}'" -f $Code, $Script:ShlinkServer
            
            if ($PSBoundParameters.ContainsKey("Domain")) {
                $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
                $QueryString.Add("domain", $Domain)
                $Params["Query"] = $QueryString
                
                $WouldMessage = $WouldMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
                $RemovingMessage = $RemovingMessage -replace "from Shlink server", ("for domain '{0}'" -f $Domain)
            }

            if ($PSCmdlet.ShouldProcess(
                $WouldMessage,
                "Are you sure you want to continue?",
                $RemovingMessage)) {
                    try {
                        InvokeShlinkRestMethod @Params
                    }
                    catch {
                        Write-Error -ErrorRecord $_
                    }
            }
        }
    }
    end {
    }
}