function Remove-ShlinkTag {
    <#
    .SYNOPSIS
        Remove a tag from an existing Shlink server.
    .DESCRIPTION
        Remove a tag from an existing Shlink server.
    .PARAMETER Tags
        Name(s) of the tag(s) you want to remove.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Remove-ShlinkTag -Tags "oldwebsite" -WhatIf
        
        Reports what would happen if the command was invoked, because the -WhatIf parameter is present.
    .EXAMPLE
        PS C:\> Remove-ShlinkTag -Tags "oldwebsite", "newwebsite"

        Removes the following tags from the Shlink server: "oldwebsite", "newwebsite"
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]]$Tags,
        
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
        $QueryString = [System.Web.HttpUtility]::ParseQueryString('')
    }
    process {
        foreach ($Tag in $Tags) {
            $QueryString.Add("tags[]", $Tag)
        }

        $Params = @{
            Endpoint = "tags"
            Method = "DELETE"
            Query = $QueryString
        }

        if ($PSCmdlet.ShouldProcess(
            ("Would delete tag(s) '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $Script:ShlinkServer),
            "Are you sure you want to continue?",
            ("Removing tag(s) '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $Script:ShlinkServer))) {
                InvokeShlinkRestMethod @Params
            }
    }
    end {
    }
}