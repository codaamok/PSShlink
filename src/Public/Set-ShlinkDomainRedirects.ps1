function Set-ShlinkDomainRedirects {
    <#
    .SYNOPSIS
        Sets the URLs that you want a visitor to get redirected to for "not found" URLs for a specific domain.
    .DESCRIPTION
        Sets the URLs that you want a visitor to get redirected to for "not found" URLs for a specific domain.
    .PARAMETER Domain
        The domain (excluding schema) in which you would like to modify the redirects of. For example, "example.com" is an acceptable value. 
    .PARAMETER BaseUrlRedirect
        Modify the 'BaseUrlRedirect' redirect setting of the domain.
    .PARAMETER Regular404Redirect
        Modify the 'Regular404Redirect' redirect setting of the domain.
    .PARAMETER InvalidShortUrlRedirect
        Modify the 'InvalidShortUrlRedirect' redirect setting of the domain.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Set-ShlinkDomainRedirects -Domain "example.com" -BaseUrlRedirect "https://someotheraddress.com"
        
        Modifies the redirect setting 'BaseUrlRedirect' of example.com to redirect to "https://someotheraddress.com".
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding(DefaultParameterSetName="BaseUrlRedirect")]
    param (
        [Parameter(Mandatory)]
        [String]$Domain,

        [Parameter(ParameterSetName="BaseUrlRedirect", Mandatory)]
        [Parameter(ParameterSetName="Regular404Redirect")]
        [Parameter(ParameterSetName="InvalidShortUrlRedirect")]
        [String]$BaseUrlRedirect,

        [Parameter(ParameterSetName="BaseUrlRedirect")]
        [Parameter(ParameterSetName="Regular404Redirect", Mandatory)]
        [Parameter(ParameterSetName="InvalidShortUrlRedirect")]
        [String]$Regular404Redirect,

        [Parameter(ParameterSetName="BaseUrlRedirect")]
        [Parameter(ParameterSetName="Regular404Redirect")]
        [Parameter(ParameterSetName="InvalidShortUrlRedirect", Mandatory)]
        [String]$InvalidShortUrlRedirect,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    try {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    }
    catch {
        Write-Error -ErrorRecord $_ -ErrorAction "Stop"
    }

    $Body = @{
        domain = $Domain
    }

    switch ($PSBoundParameters.Keys) {
        "BaseUrlRedirect" {
            $Body["baseUrlRedirect"] = $BaseUrlRedirect
        }
        "Regular404Redirect" {
            $Body["regular404Redirect"] = $Regular404Redirect
        }
        "InvalidShortUrlRedirect" {
            $Body["invalidShortUrlRedirect"] = $InvalidShortUrlRedirect
        }
    }

    $Params = @{
        Endpoint    = "domains"
        Path        = "redirects"
        Method      = "PATCH"
        Body        = $Body
        ErrorAction = "Stop"
    }

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}