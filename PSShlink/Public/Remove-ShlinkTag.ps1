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
    .EXAMPLE
        PS C:\> "tag1","tag2" | Remove-ShlinkTag

        Removes "tag1" and "tag2" from your Shlink instance.
    .EXAMPLE
        PS C:\> Get-ShlinkUrl -ShortCode "profile" | Remove-ShlinkTag

        Removes all the tags which are associated with the short code "profile" from the Shlink instance.
    .INPUTS
        System.String[]

        Used for the -Tags parameter.
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

        # Gather all tags and check if any of the user's desired tag(s) to delete
        # are currently an existing tag within the process / for loop later.
        # This is because the REST API does not produce any kind of feedback if the
        # user attempts to delete a tag which does not exist.
        $AllTags = Get-ShlinkTags
    }
    process {
        foreach ($Tag in $Tags) {
            if ($AllTags.tag -notcontains $Tag) {
                $WriteErrorSplat = @{
                    Message      = "Tag '{0}' does not exist on Shlink server '{1}'" -f $Tag, $Script:ShlinkServer
                    Category     = "ObjectNotFound"
                    TargetObject = $Tag
                }
                Write-Error @WriteErrorSplat
                continue
            }
            else {
                $QueryString.Add("tags[]", $Tag)
            }

            $Params = @{
                Endpoint    = "tags"
                Method      = "DELETE"
                Query       = $QueryString
                ErrorAction = "Stop"
            }
    
            if ($PSCmdlet.ShouldProcess(
                ("Would delete tag '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $Script:ShlinkServer),
                "Are you sure you want to continue?",
                ("Removing tag '{0}' from Shlink server '{1}'" -f ([String]::Join("', '", $Tags)), $Script:ShlinkServer))) {
                    try {
                        InvokeShlinkRestMethod @Params
                    }
                    catch {
                        Write-Error -ErrorRecord $_
                    }
                }
        }
    }
    end {
    }
}