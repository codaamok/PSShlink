function Get-ShlinkUrlQrCode {
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
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]]$ShortCode,

        [Parameter()]
        [Int]$Size = 300,

        [Parameter()]
        [ValidateSet("png","svg")]
        [String]$Format = "png",

        [Parameter()]
        [String]$Path = "{0}\Downloads" -f $home,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
        $QueryString.Add("format", $Format)
    }
    process {
        foreach ($item in $ShortCode) {
            $Params = @{
                OutFile = "{0}\Shlink_{1}.{2}" -f $Path, $item, $Format
                Uri     = "{0}/{1}/qr-code/{2}?{3}" -f $Script:ShlinkServer, $item, $Size, $QueryString.ToString()
            }
            Invoke-RestMethod @Params
        }
    }
    end {
    }
}