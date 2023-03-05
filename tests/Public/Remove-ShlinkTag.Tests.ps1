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

Describe "Remove-ShlinkTag" {
    It "Removes a tag from the Shlink instance (WhatIf enabled: <WhatIf>)" -TestCases @(
        @{ WhatIf = $true  }
        @{ WhatIf = $false }
    ) {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }

        Remove-ShlinkTag -Tag 'psshlinktag1' -Confirm:$false -WhatIf:$WhatIf @Params

        switch ($WhatIf) {
            $true {
                Get-ShlinkTags -SearchTerm 'psshlinktag1' @Params | Should -Not -BeNullOrEmpty
            }
            $false {
                Get-ShlinkTags -SearchTerm 'psshlinktag1' @Params | Should -BeNullOrEmpty
            }
        }
    }

    It "Remove all tags" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }

        Get-ShlinkTags @Params | Remove-ShlinkTag @Params -Confirm:$false

        Get-ShlinkTags @Params | Should -BeNullOrEmpty
    }

}