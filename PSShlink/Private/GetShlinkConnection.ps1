function GetShlinkConnection {
    param (
        [Parameter()]
        [String]$Server,
        [Parameter()]
        [SecureString]$ApiKey
    )
    if (-not $Script:ShlinkServer) {
        if ([String]::IsNullOrWhitespace($Server)) {
            $Script:ShlinkServer = Read-Host -Prompt "Enter your Shlink server URL (e.g. https://example.com)"
        }
        else {
            $Script:ShlinkServer = $Server
        }
    }
    if (-not $Script:ShlinkApiKey) {
        if ([String]::IsNullOrWhitespace($ApiKey)) {
            $Script:ShlinkApiKey = Read-Host -Prompt "Enter your Shlink server API key" -AsSecureString
        }
        else {
            $Script:ShlinkApiKey = $ApiKey
        }
    }
}