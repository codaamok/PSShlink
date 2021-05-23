function GetShlinkConnection {
    param (
        [Parameter()]
        [String]$Server,
        
        [Parameter()]
        [SecureString]$ApiKey,

        [Parameter()]
        [Switch]$ServerOnly
    )

    $Script:MinSupportedShlinkVersion = [Version]"2.7.0"

    if (-not ("System.Web.HttpUtility" -as [Type])) {
        Add-Type -AssemblyName "System.Web" -ErrorAction "Stop"
    }

    if ([String]::IsNullOrWhiteSpace($Server) -And -not $Script:ShlinkServer) {
        # User has not yet used use a -ShlinkServer paramater from any of the functions, therefore prompt
        $Script:ShlinkServer = Read-Host -Prompt "Enter your Shlink server URL (e.g. https://example.com)"
    }
    elseif (-not [String]::IsNullOrWhiteSpace($Server) -And $Script:ShlinkServer -ne $Server) {
        # User has previously used a -ShlinkServer parameter and is using it right now, and its value is different to what was used last in any of the functions
        # In other words, it has changes - they wish to use a different server
        $Script:ShlinkServer = $Server
        # Set this to false so we can go through the motions again of checking the new Shlink server's version number
        $Script:GetShlinkConnectionHasRun = $false
        # We no longer know if the new server's Shlink version is supported for PSShlink
        Clear-Variable -Name "ShlinkVersionIsSupported" -Scope "Script" -ErrorAction "SilentlyContinue"
    }

    if ([String]::IsNullOrWhitespace($ApiKey) -And -not $Script:ShlinkApiKey -And -not $ServerOnly) {
        # User has not yet used use a -ShlinkApiKey paramater from any of the functions, therefore prompt
        $Script:ShlinkApiKey = Read-Host -Prompt "Enter your Shlink server API key" -AsSecureString
    }
    elseif (-not [String]::IsNullOrWhiteSpace($ApiKey) -And $Script:ShlinkApiKey -ne $ApiKey) {
        # User has previously used a -ShlinkApiKey parameter and is using it right now, and its value is different to what was used last in any of the functions
        # In other words, it has changed - they wish to use a different API key
        $Script:ShlinkApiKey = $ApiKey
    }

    # Query the Shlink server for version, only on the first run of GetShlinkConnection, otherwise it
    # will enter an infinite loop of recursion and hit the PowerShell recursion limit. I want a user
    # experience of being warned each time they use a function on an unsupported Shlink server version.
    if (-not $Script:GetShlinkConnectionHasRun) {
        $Script:GetShlinkConnectionHasRun = $true
        $Script:ShlinkVersion = Get-ShlinkServer -ShlinkServer $Script:ShlinkServer -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty Version

        if (-not $Script:ShlinkVersion) {
            $Script:GetShlinkConnectionHasRun = $false
            Write-Error -Message ("Could not determine the version of Shlink on '{0}'" -f $Script:ShlinkServer) -Category "InvalidData" -TargetObject $Script:ShlinkServer -ErrorAction "Stop"
        }
        elseif ([Version]$Script:ShlinkVersion -lt [Version]$Script:MinSupportedShlinkVersion) {
            $Script:ShlinkVersionIsSupported = $false
        }
        else {
            $Script:ShlinkVersionIsSupported = $true
        }
    }

    if ($Script:ShlinkVersionIsSupported -eq $false -And $Script:ShlinkVersion) {
        Write-Warning -Message ("PSShlink supports Shlink {0} or newer, your Shlink server is {1}. Some functions may not work as intended. Consider upgrading your Shlink instance." -f $Script:MinSupportedShlinkVersion, $Script:ShlinkVersion)
    }    
}