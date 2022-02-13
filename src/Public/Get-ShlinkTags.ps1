function Get-ShlinkTags {
    <#
    .SYNOPSIS
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .DESCRIPTION
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .PARAMETER SearchTerm
        A query used to filter results by searching for it on the tag name.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Get-ShlinkTags
        
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .EXAMPLE
        PS C:\> Get-ShlinkTags -SearchTerm "pwsh"

        Returns the list of all tags used in any short URL, including stats and ordered by name, where those match the term "pwsh" by name of tag.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$SearchTerm,

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
    
    $QueryString = [System.Web.HttpUtility]::ParseQueryString('')

    $Params = @{
        Endpoint     = "tags"
        Path         = "stats"
        PropertyTree = "tags", "data"
    }

    if ($PSBoundParameters.ContainsKey("SearchTerm")) {
        $QueryString.Add("searchTerm", $SearchTerm)
    }

    $Params["Query"] = $QueryString

    try {
        InvokeShlinkRestMethod @Params
    }
    catch {
        Write-Error -ErrorRecord $_
    }
}