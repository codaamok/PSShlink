$PesterConfig = New-PesterConfiguration -Hashtable @{
    Run = @{
        Path = @(
            "{0}/Public/New-*.Acceptance.Tests.ps1" -f $PSScriptRoot
            "{0}/Public/Get-*.Acceptance.Tests.ps1" -f $PSScriptRoot
            "{0}/Public/Save-*.Acceptance.Tests.ps1" -f $PSScriptRoot
            "{0}/Public/Set-ShlinkUrl.Acceptance.Tests.ps1" -f $PSScriptRoot
            "{0}/Public/Set-ShlinkTag.Acceptance.Tests.ps1" -f $PSScriptRoot
            "{0}/Public/Remove-*.Acceptance.Tests.ps1" -f $PSScriptRoot
        )
        Exit = $true
        SkipRemainingOnFailure = 'Block'
    }
    Output = @{
        Verbosity = 'Detailed'
    }
}

Invoke-Pester -Configuration $PesterConfig -ErrorAction 'Stop'
