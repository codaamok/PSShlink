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

Describe "Get-ShlinkVisits" {
    It "Get summary of all the server's visits" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisits @Params
        $Object.Server | Should -Be $env:ShlinkServer
        [int]$Object.visitsCount | Should -BeOfType [int]
    }

    It "Get visit data for a specific shortcode" {
        $Params = @{
            ShortCode    = 'PSShlink-Test'
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisits @Params
        $Count = $Object.count
        Invoke-WebRequest 'http://psshlink.codaamok/PSShlink-Test' -ErrorAction 'Stop'
        $Object = Get-ShlinkVisits @Params
        $Object.Count | Should -Be ($Count + 1)
    }

    It "Get visit data for tag 'psshlinktag<_>'" -TestCases 1,2 {
        $Params = @{
            Tag          = 'psshlinktag{0}' -f $_
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisits @Params
        $Count = $Object.count
        Invoke-WebRequest 'http://psshlink.codaamok/PSShlink-Test' -ErrorAction 'Stop'
        $Object = Get-ShlinkVisits @Params
        $Object.Count | Should -Be ($Count + 1)
    }

    It "Get visits data after a specified date" {
        Start-Sleep -Seconds 1
        $Date = Get-Date
        $Params = @{
            ShortCode    = 'PSShlink-Test'
            StartDate    = $Date
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisits @Params
        $Object | Should -BeNullOrEmpty
        Invoke-WebRequest 'http://psshlink.codaamok/PSShlink-Test' -ErrorAction 'Stop'
        $Object = Get-ShlinkVisits @Params
        $Object.Count | Should -Be 1
    }
}