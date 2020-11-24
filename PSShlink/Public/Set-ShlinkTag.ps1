function Set-ShlinkTag {
    <#
    .SYNOPSIS
        Renames an existing tag to a new value on the Shlink server.
    .DESCRIPTION
        Renames an existing tag to a new value on the Shlink server.
    .PARAMETER OldTagName
        The name of the old tag you want to change the name of.
    .PARAMETER NewTagName
        The name fo the new tag you want to the new name to be.
    .PARAMETER ShlinkServer
        The URL of your Shlink server (including schema). For example "https://example.com".
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .PARAMETER ShlinkApiKey
        A SecureString object of your Shlink server's API key.
        It is not required to use this parameter for every use of this function. When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.
    .EXAMPLE
        PS C:\> Set-ShlinkTag -OldTagName "oldwebsite" -NewTagName "veryoldwebsite"
        
        Updates the tag with the name "oldwebsite" to have a new name of "veryoldwebsite".
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]$OldTagName,

        [Parameter(Mandatory)]
        [String]$NewTagName,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey

    $Params = @{
        Endpoint = "tags"
        Method = "PUT"
        Body = @{
            oldName = $OldTagName
            newName = $NewTagName
        }
    }

    InvokeShlinkRestMethod @Params
}