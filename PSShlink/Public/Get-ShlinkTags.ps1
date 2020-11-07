function Get-ShlinkTags {
    <#
    .SYNOPSIS
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .DESCRIPTION
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .EXAMPLE
        PS C:\> Get-ShlinkTags
        
        Returns the list of all tags used in any short URL, including stats and ordered by name.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        $QueryString.Add("withStats", "true")

        $Params = @{
            Endpoint = "tags"
            ChildPropertyName = "tags"
            PropertyTree = @("tags","stats")
        }

        $Params["Query"] = $QueryString

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}