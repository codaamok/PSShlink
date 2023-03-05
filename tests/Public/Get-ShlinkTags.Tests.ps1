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

Describe "Get-ShlinkTags" {
    It "Returns all tags on the Shlink instance" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkTags @Params
        $Object.tag            | Should -Be 'psshlinktag1', 'psshlinktag2'
        $Object.shortUrlsCount | Should -Be '1','1'
    }

    It "Returns tags on Shlink instance using search term '<_>'" -ForEach 1,2 {
        $Params = @{
            SearchTerm   = $_
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkTags @Params
        $Object.tag            | Should -Be ('psshlinktag{0}' -f $_)
    }
}