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

Describe "New-ShlinkUrl" {
    It "New valid short URL" {
        $Params = @{
            LongUrl      = 'https://google.co.uk'
            CustomSlug   = 'PSShlink-Test'
            Tags         = 'psshlinktag1', 'psshlinktag2'
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = New-ShlinkUrl @Params
        $Object.shortCode | Should -Be 'PSShlink-Test'
        $Object.shortUrl  | Should -Be ('{0}/PSShlink-Test' -f $env:ShlinkServer)
        $Object.tags      | Should -Be 'psshlinktag1', 'psshlinktag2'
        $Object.longUrl   | Should -Be 'https://google.co.uk'
    }

    It "New invalid short URL" {
        $Guid = (New-Guid).Guid
        $Params = @{
            LongUrl      = 'https://{0}.com' -f ([String[]]$Guid * 3 -join '-')
            CustomSlug   = $Guid
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ValidateUrl  = $true
            ErrorAction  = 'Stop'
        }
        { New-ShlinkUrl @Params } | Should -Throw -ExceptionType ([System.ArgumentException])
    }

    It "New invalid short URL with validation off" {
        $Guid = (New-Guid).Guid
        $Url = 'https://{0}.com' -f ([String[]]$Guid * 3 -join '-')
        { Invoke-WebRequest -Uri $Url -ErrorAction 'Stop' } | Should -Throw -ExceptionType ([System.Net.Http.HttpRequestException])
        $Params = @{
            LongUrl      = $Url
            CustomSlug   = $Guid
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ValidateUrl  = $false
            ErrorAction  = 'Stop'
        }
        $Object = New-ShlinkUrl @Params
        $Object.shortCode | Should -Be $Guid
        $Object.shortUrl  | Should -Be ('{0}/{1}' -f $env:ShlinkServer, $Guid)
        $Object.longUrl   | Should -Be $Url
    }
}
