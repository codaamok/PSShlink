function GetPaginationData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [PSObject]$Object,

        [Parameter()]
        [String]$ChildPropertyName
    )
    
    $Result = if ($ChildPropertyName) {
        $Object.$ChildPropertyName.pagination
    }
    else {
        $Object.pagination
    }

    if (-not $Result) {
        "None"
    }
}