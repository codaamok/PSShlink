BeforeAll {
    # Check if module is already imported, as it can be via VSCode task where you can choose what code base to test
    # and you might not want to cloober it with the non-built code
    if (-not (Get-Module PSShlink)) {
        Import-Module $PSScriptRoot/../../src/PSShlink.psd1 -Force
    }
}

Describe "Create new short URLs" {
    It "New valid short URL" {
        $Guid = (New-Guid).Guid
        $Splat = @{
            LongUrl      = 'https://google.co.uk'
            CustomSlug   = $Guid
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = New-ShlinkUrl @Splat
        $Object.shortCode | Should -Be $Guid
        $Object.shortUrl  | Should -Be ('{0}/{1}' -f $env:ShlinkServer, $Guid)
        $Object.longUrl   | Should -Be 'https://google.co.uk'
    }

    It "New invalid short URL" {
        $Guid = (New-Guid).Guid
        $Splat = @{
            LongUrl      = 'https://{0}.com' -f (New-Guid).Guid
            CustomSlug   = $Guid
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        { New-ShlinkUrl @Splat } | Should -Throw -ExceptionType ([System.ArgumentException])
    }

    It "New invalid short URL with validation off" {
        $Guid = (New-Guid).Guid
        # Multiply guid string by 3 because ideally we *really* do not want a valid URL
        $Url = 'https://{0}.com' -f ($Guid * 3)

        { Invoke-WebRequest -Uri $Url -ErrorAction 'Stop' } | Should -Throw -ExceptionType ([System.Net.Http.HttpRequestException])

        $Splat = @{
            LongUrl      = $Url
            CustomSlug   = $Guid
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ValidateUrl  = $false
            ErrorAction  = 'Stop'
        }
        $Object = New-ShlinkUrl @Splat
        $Object.shortCode | Should -Be $Guid
        $Object.shortUrl  | Should -Be ('{0}/{1}' -f $env:ShlinkServer, $Guid)
        $Object.longUrl   | Should -Be $Url
    }
}
