function GetShlinkConnection {
    param (
        [Parameter()]
        [String]$Server,
        
        [Parameter()]
        [SecureString]$ApiKey,

        [Parameter()]
        [Switch]$ServerOnly
    )

    if (-not ("System.Web.HttpUtility" -as [Type])) {
        Add-Type -AssemblyName "System.Web" -ErrorAction "Stop"
    }

    if (-not $Script:ShlinkServer) {
        if ([String]::IsNullOrWhitespace($Server)) {
            $Script:ShlinkServer = Read-Host -Prompt "Enter your Shlink server URL (e.g. https://example.com)"
        }
        else {
            $Script:ShlinkServer = $Server
        }
    }
    if (-not $Script:ShlinkApiKey -And -not $ServerOnly.IsPresent) {
        if ([String]::IsNullOrWhitespace($ApiKey)) {
            $Script:ShlinkApiKey = Read-Host -Prompt "Enter your Shlink server API key" -AsSecureString
        }
        else {
            $Script:ShlinkApiKey = $ApiKey
        }
    }

    # Query the Shlink server for version, only on the first run of GetShlinkConnection, otherwise it
    # will enter an infinite loop of recursion and hit the PowerShell recursion limit. I want a user
    # experience of being warned each time they use a function on an unsupported Shlink server version.
    if (-not $Script:GetShlinkConnectionHasRun) {
        $Script:GetShlinkConnectionHasRun = $true
        $Script:ShlinkVersion = Get-ShlinkServer | Select-Object -ExpandProperty Version
        $Script:MinSupportedShlinkVersion = [Version]"2.4.0"

        if ([Version]$Script:ShlinkVersion -lt [Version]$Script:MinSupportedShlinkVersion) {
            $Script:ShlinkVersionIsSupported = $false
        }
        else {
            $Script:ShlinkVersionIsSupported = $true
        }
    }

    if ($Script:ShlinkVersionIsSupported -eq $false) {
        Write-Warning -Message ("PSShlink supports Shlink {0} or newer, your Shlink server is {1}. Some functions may not work as intended. Consider upgrading your Shlink instance." -f $Script:MinSupportedShlinkVersion, $Script:ShlinkVersion)
    }    
}