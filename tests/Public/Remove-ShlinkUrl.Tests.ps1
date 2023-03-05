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

Describe "Remove-ShlinkUrl" {
    It "Removes a short code URL from the Shlink instance (WhatIf enabled: <WhatIf>)" -TestCases @(
        @{ WhatIf = $true  }
        @{ WhatIf = $false }
    ) {
        $Params = @{
            ShortCode    = 'PSShlink-Test'
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            Confirm      = $false
            WhatIf       = $WhatIf
            ErrorAction  = 'Stop'
        }
        Remove-ShlinkUrl @Params

        switch ($WhatIf) {
            $true {
                Get-ShlinkUrl -ShortCode 'PSShlink-Test' | Should -Not -BeNullOrEmpty
            }
            $false {
                { Get-ShlinkUrl -ShortCode 'PSShlink-Test' -ErrorAction 'Stop' } | Should -Throw -ExceptionType ([System.Management.Automation.ItemNotFoundException])
            }
        }

    }

    It "Remove all short codes" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }

        Get-ShlinkUrl @Params | Remove-ShlinkUrl @Params -Confirm:$false

        Get-ShlinkUrl @Params | Should -BeNullOrEmpty
    }
}