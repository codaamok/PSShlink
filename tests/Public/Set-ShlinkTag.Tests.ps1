BeforeAll {
    # Always use built code if running in a pipeline
    if ($env:USER -eq 'runner') {
        Import-Module "$PSScriptRoot/../../build/PSShlink/PSShlink.psd1" -Force
    }
    # Check if module is already imported, as it can be via VSCode task where you can choose what code base to test
    # and you might not want to cloober it with the non-built code
    elseif (-not (Get-Module PSShlink)) {
        Import-Module "$PSScriptRoot/../../src/PSShlink.psd1" -Force
    }
}

Describe "Set-ShlinkTag" {
    It "Rename an existing tag" {
        $Params = @{
            OldTagName   = 'psshlinktag3'
            NewTagName   = 'psshlinktag5'
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        Set-ShlinkTag @Params

        $Params = @{
            OldTagName   = 'psshlinktag3'
            NewTagName   = 'psshlinktag5'
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkTags -SearchTerm 'psshlinktag5'
        $Object.Count | Should -Be 1
        $Object.tag   | Should -Be 'psshlinktag5'
    }
}