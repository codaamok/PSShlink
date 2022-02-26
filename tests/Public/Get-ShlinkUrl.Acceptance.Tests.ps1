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

Describe "Get-ShlinkUrl" {
    It "Retrieve 'PSShlink-Test' short URL <type>" -ForEach @(
        @{ Type = 'exactly'; Parameter = 'ShortCode';  Value = 'PSShlink-Test' }
        @{ Type = 'vaguely'; Parameter = 'SearchTerm'; Value = 'test'          }
    ) {
        $Params = @{
            $Parameter   = $Value
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkUrl @Params
        $Object.shortCode | Should -Be 'PSShlink-Test'
        $Object.shortUrl  | Should -Be ('{0}/PSShlink-Test' -f $env:ShlinkServer)
        $Object.tags      | Should -Be 'PSShlinkTag1', 'PSShlinkTag2'
        $Object.longUrl   | Should -Be 'https://google.co.uk'
    }
}