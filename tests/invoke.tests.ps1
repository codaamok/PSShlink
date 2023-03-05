$PesterConfig = New-PesterConfiguration -Hashtable @{
    Run = @{
        Path = @(
            '{0}/Public/New-*.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Get-*.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Save-*.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Set-ShlinkUrl.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Set-ShlinkTag.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Remove-*.Tests.ps1' -f $PSScriptRoot
        )
        Throw = $true
        SkipRemainingOnFailure = 'Block'
    }
    Output = @{
        Verbosity = 'Detailed'
    }
    TestResult = @{
        Enabled = $true
        OutputFormat = 'NUnit2.5'
    }
}

Invoke-Pester -Configuration $PesterConfig -ErrorAction 'Stop'
