function Get-ShlinkDomains {
    <#
    .SYNOPSIS
        Returns the list of all domains ever used, with a flag that tells if they are the default domain
    .DESCRIPTION
        Returns the list of all domains ever used, with a flag that tells if they are the default domain
    .EXAMPLE
        PS C:\> Get-ShlinkDomains

        Returns the list of all domains ever used, with a flag that tells if they are the default domain
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        ??
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$ShlinkServer,

        [Parameter()]
        [SecureString]$ShlinkApiKey
    )

    GetShlinkConnection -Server $ShlinkServer -ApiKey $ShlinkApiKey

    InvokeShlinkRestMethod -EndPoint "domains" 
}