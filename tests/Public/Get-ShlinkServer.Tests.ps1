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

Describe "Get-ShlinkServer" {
    It "Returns Shlink instance information" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkServer @Params
        $Object.status | Should -Be 'Pass'
        [System.Version]$Object.version | Should -BeOfType [System.Version]
    }
}