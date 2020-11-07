function Get-ShlinkTags {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
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