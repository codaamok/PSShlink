function Set-ShlinkTag {
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
    begin {
        GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey
    }
    process {
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
    end {
    }
}