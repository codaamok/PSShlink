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

Describe "Get-ShlinkVisitsOrphan" {
    It "Get (orphan) visit data for the Shlink instance" {
        $Params = @{
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisitsOrphan @Params
        $Count = $Object.Count
        try {
            $Url = '{0}/{1}' -f $env:ShlinkServer, (New-Guid).Guid
            Invoke-WebRequest $Url -ErrorAction 'Stop'
        }
        catch {
            $_.Exception.Response.StatusCode | Should -Be 'NotFound'
        }
        $Object = Get-ShlinkVisitsOrphan @Params
        $Object.Count | Should -Be ($Count + 1)
    }

    It "Get (orphan) visit data for the Shlink instance after a specified date" {
        Start-Sleep -Seconds 1
        $Date = Get-Date
        $Params = @{
            StartDate    = $Date
            ShlinkServer = $env:ShlinkServer
            ShlinkApiKey = $env:ShlinkAPIKey | ConvertTo-SecureString
            ErrorAction  = 'Stop'
        }
        $Object = Get-ShlinkVisitsOrphan @Params
        $Object | Should -BeNullOrEmpty
        try {
            $Url = '{0}/{1}' -f $env:ShlinkServer, (New-Guid).Guid
            Invoke-WebRequest $Url -ErrorAction 'Stop'
        }
        catch {
            $_.Exception.Response.StatusCode | Should -Be 'NotFound'
        }
        $Object = Get-ShlinkVisitsOrphan @Params
        $Object.Count | Should -Be 1
    }
}
