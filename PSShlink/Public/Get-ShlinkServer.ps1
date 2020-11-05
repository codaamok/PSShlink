function Get-ShlinkServer {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ServerOnly
    }
    process {
        $Uri = "{0}/rest/health" -f $Script:ShlinkServer
    
        Invoke-RestMethod -Uri $Uri
    }
    end {
    }
}