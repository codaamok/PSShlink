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

Describe "Set-ShlinkUrl" {
    It "Update an existing short code" {
        $Date = Get-Date '2000-01-01 00:00:00'
        $Params = @{
            ShortCode    = 'PSShlink-Test'
            LongUrl      = 'https://google.com'
            Tags         = 'psshlinktag3','psshlinktag4'
            ValidSince   = $Date.AddDays(-1)
            ValidUntil   = $Date.AddDays(1)
            MaxVisits    = 100
            Title        = 'Google (USA)'
            ForwardQuery = $false
            Crawlable    = $true
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Set-ShlinkUrl @Params
        $Object.longUrl         | Should -Be 'https://google.com'
        $Object.tags            | Should -Be 'psshlinktag3','psshlinktag4'
        $Object.meta.validSince | Should -Be $Date.AddDays(-1)
        $Object.meta.validUntil | Should -Be $Date.AddDays(1)
        $Object.meta.maxVisits  | Should -Be 100
        $Object.title           | Should -be 'Google (USA)'
        $Object.forwardQuery    | Should -BeFalse
        $Object.crawlable       | Should -BeTrue
    }
}