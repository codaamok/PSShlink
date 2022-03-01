$PesterConfig = New-PesterConfiguration -Hashtable @{
    Run = @{
        Path = @(
            '{0}/Public/New-*.Acceptance.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Get-*.Acceptance.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Save-*.Acceptance.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Set-ShlinkUrl.Acceptance.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Set-ShlinkTag.Acceptance.Tests.ps1' -f $PSScriptRoot
            '{0}/Public/Remove-*.Acceptance.Tests.ps1' -f $PSScriptRoot
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
