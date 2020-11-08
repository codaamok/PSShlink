function New-ShlinkTag {
    <#
    .SYNOPSIS
        Creates one or more new tags on your Shlink server
    .DESCRIPTION
        Creates one or more new tags on your Shlink server
    .PARAMETER Tags
        Name(s) for your new tag(s)
    .EXAMPLE
        PS C:\> New-ShlinkTag -Tags "oldwebsite","newwebsite","misc"
        
        Creates the following new tags on your Shlink server: "oldwebsite","newwebsite","misc"
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Management.Automation.PSObject
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String[]]$Tags,

        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    }
    process {
        $Params = @{
            Endpoint = "tags"
            Method = "POST"
            Body = @{
                tags = @($Tags)
            }
            PropertyTree = @(
                "tags"
                "data"
            )
        }

        InvokeShlinkRestMethod @Params
    }
    end {
    }
}