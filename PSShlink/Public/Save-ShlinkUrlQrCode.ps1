function Save-ShlinkUrlQrCode {
    <#
    .SYNOPSIS
        Save a QR code to disk for a short code.
    .DESCRIPTION
        Save a QR code to disk for a short code.
        The default size of images is 300x300 and the default file type is png.
        The default folder for files to be saved to is $HOME\Downloads. The naming convention for the saved files is as follows: ShlinkQRCode_<shortCode>_<domain>_<size>.<format>
    .EXAMPLE
        PS C:\> Save-ShlinkUrlQrCode -ShortCode "profile" -Domain "example.com" -Size 1000 -Format svg -Path "C:\temp"
        
        Saves a QR code to disk in C:\temp named "ShlinkQRCode_profile_example-com_1000.svg". It will be saved as 1000x1000 pixels and of SVG type.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -SearchTerm "someword" | Save-ShlinkUrlQrCode -Path "C:\temp"

        Saves QR codes for all short URLs returned by the Get-ShlinkUrl call. All files will be saved as the default values for size (300x300) and type (png). All files will be saved in "C:\temp" using the normal naming convention for file names, as detailed in the description.
    .INPUTS
        System.Management.Automation.PSObject
    .OUTPUTS
        System.Management.Automation.PSObject
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

            # Force result to be scalar, otherwise it returns as a collection of 1 element.
            # Thanks to Chris Dent for this being a big "ah-ha!" momemnt for me, especially
            # when piping stuff to Get-Member
            $Object = Get-ShlinkUrl @Params | ForEach-Object { $_ }

            if ([String]::IsNullOrWhiteSpace($Object.Domain)) {
                # We can safely assume the ShlinkServer variable will be set due to the Get-ShlinkUrl call
                # i.e. if it is not, then Get-ShlinkUrl will prompt the user for it and therefore set the variable
                $Object.Domain = [Uri]$Script:ShlinkServer | Select-Object -ExpandProperty "Host"
            }

            $InputObject = $Object
        }
    }
    process {
        foreach ($Object in $InputObject) {
            if ([String]::IsNullOrWhiteSpace($Object.Domain)) {
                $Object.Domain = [Uri]$Script:ShlinkServer | Select-Object -ExpandProperty "Host"
            }

            $Params = @{
                OutFile = "{0}\ShlinkQRCode_{1}_{2}_{3}.{4}" -f $Path, $Object.ShortCode, ($Object.Domain -replace "\.", "-"), $Size, $Format
                Uri     = "{0}/qr-code/{1}?{2}" -f $Object.ShortUrl, $Size, $QueryString.ToString()
            }

            Invoke-RestMethod @Params
        }
    }
    end {
    }
}