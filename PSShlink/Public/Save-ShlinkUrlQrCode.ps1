function Save-ShlinkUrlQrCode {
    <#
    .SYNOPSIS
        Save a QR code to disk for a short code.
    .DESCRIPTION
        Save a QR code to disk for a short code. It is possible to configure the QR code's size, file type and path 
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
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName="InputObject")]
        [PSTypeName('PSShlink')]
        [PSCustomObject[]]$InputObject,

        [Parameter(Mandatory, ParameterSetName="SpecifyProperties")]
        [String]$ShortCode,

        [Parameter(ParameterSetName="SpecifyProperties")]
        [String]$Domain,

        [Parameter()]
        [Int]$Size = 300,

        [Parameter()]
        [ValidateSet("png","svg")]
        [String]$Format = "png",

        [Parameter()]
        [String]$Path = "{0}\Downloads" -f $home,

        [Parameter(ParameterSetName="SpecifyProperties")]
        [String]$ShlinkServer,

        [Parameter(ParameterSetName="SpecifyProperties")]
        [SecureString]$ShlinkApiKey
    )
    begin {
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
        $QueryString.Add("format", $Format)

        if ($PSCmdlet.ParameterSetName -ne "InputObject") {
            $Params = @{ 
                ShortCode    = $ShortCode
                ShlinkServer = $ShlinkServer
                ShlinkApiKey = $ShlinkApiKey
            }

            if ($PSBoundParameters.ContainsKey("Domain")) {
                $Params["Domain"] = $Domain
            }

            $ShlinkUrl = Get-ShlinkUrl @Params

            $InputObject = [PSCustomObject]@{
                ShortCode = $ShortCode
                ShortUrl  = $ShlinkUrl.shortUrl
                Domain    = if ([String]::IsNullOrWhiteSpace($ShlinkUrl.Domain)) {
                    # We can safely assume the ShlinkServer variable will be set due to the Get-ShlinkUrl call
                    # i.e. if it is not, then Get-ShlinkUrl will prompt the user for it and therefore set the variable
                    [Uri]$Script:ShlinkServer | Select-Object -ExpandProperty "Host"
                }
                else {
                    $ShlinkUrl.Domain
                }
            }
        }
    }
    process {
        foreach ($Object in $InputObject) {
            if ([String]::IsNullOrWhiteSpace($Object.Domain)) {
                $Object.Domain = [Uri]$Script:ShlinkServer | Select-Object -ExpandProperty "Host"
            }

            $Params = @{
                OutFile = "{0}\ShlinkQRCode_{1}_{2}.{3}" -f $Path, $Object.ShortCode, ($Object.Domain -replace "\.", "-"), $Format
                Uri     = "{0}/qr-code/{1}?{2}" -f $Object.ShortUrl, $Size, $QueryString.ToString()
            }

            Invoke-RestMethod @Params
        }
    }
    end {
    }
}