BeforeAll {
    # Check if module is already imported, as it can be via VSCode task where you can choose what code base to test
    # and you might not want to cloober it with the non-built code
    if (-not (Get-Module PSShlink)) {
        Import-Module $PSScriptRoot/../../src/PSShlink.psd1 -Force
    }
}

Describe "Save-ShlinkUrlQrCode" {
    It "Create '<Format>' QR code image file of expected SHA256 hash '<SHA256>'" -TestCases @(
        @{ Format = 'png'; SHA256 = 'A3D4EA74661878D8AB15AD864705AB43A095D5B60416F0B33F3E5212EEB527EF' }
        @{ Format = 'svg'; SHA256 = '380E532048FD830255CF8C34579D92813CB0B78F131D0E5790257A3155943391' }
    ) {
        $Params = @{
            Path            = $TestDrive
            ShortCode       = 'PSShlink-Test'
            Format          = $Format
            Size            = 100
            Margin          = 10
            ErrorCorrection = 'L'
            RoundBlockSize  = $false
            ShlinkServer    = $env:ShlinkServer
            ShlinkApiKey    = $env:ShlinkAPIKey | ConvertTo-SecureString
            PassThru        = $true
            ErrorAction     = 'Stop'
        }
        $File = Save-ShlinkUrlQrCode @Params

        (Get-FileHash $File -Algorithm SHA256).Hash | Should -Be $SHA256
    }
}
