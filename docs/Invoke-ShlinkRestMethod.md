---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Invoke-ShlinkRestMethod

## SYNOPSIS
Query a Shlink server's REST API

## SYNTAX

```
Invoke-ShlinkRestMethod [-Endpoint] <String> [[-Path] <String>] [[-Query] <HttpUtility>]
 [[-ApiVersion] <Int32>] [[-Method] <WebRequestMethod>] [[-PropertyTree] <String[]>] [[-ShlinkServer] <String>]
 [[-ShlinkApiKey] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
This function provides flexibility to query a Shlink's server how you want to. 

Specify all the parameters, endpoint, and path details you need.

All data from all pages are returned.

See Shlink's REST API documentation: https://shlink.io/documentation/api-docs/ and https://api-spec.shlink.io/

## EXAMPLES

### EXAMPLE 1
```
Invoke-ShlinkRestMethod -Endpoint "short-urls" -PropertyTree "shortUrls", "Data" -Query [System.Web.HttpUtility]::ParseQueryString("searchTerm", "abc")
```

Gets all short codes from Shlink matching the search term "abc".

Note (it's not obvious), you can add more query params to an instance of HttpUtility like you can any dictionary by using the .Add() method on the object.

### EXAMPLE 2
```
Invoke-ShlinkRestMethod -Endpoint "short-urls" -Path "abc" -METHOD "DELETE"
```

Deletes the shortcode "abc" from Shlink.

### EXAMPLE 3
```
Invoke-ShlinkRestMethod -Endpoint "tags" -Path "stats"
```

Gets all tags with statistics.

## PARAMETERS

### -Endpoint
The endpoint to use in the request.
This is before the -Path.
See the examples for example usage.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to use in the request.
This is after the -Endpoint.
See the examples for example usage.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
The query to use in the request.
Must be an instance of System.Web.HttpUtility.
See the examples for example usage.

Note (it's not obvious), you can add more query params to an instance of HttpUtility like you can any dictionary by using the .Add() method on the object.

```yaml
Type: HttpUtility
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiVersion
The API version of Shlink to use in the request.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
The HTTP method to use in the request.

```yaml
Type: WebRequestMethod
Parameter Sets: (All)
Aliases:
Accepted values: Default, Get, Head, Post, Put, Delete, Trace, Options, Merge, Patch

Required: False
Position: 5
Default value: GET
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropertyTree
Data returned by Shlink's rest API is usually embedded within one or two properties.

Here you can specify the embedded properties as a string array in the order you need to select them to access the data.

For example, the "short-urls" endpoint includes the data within the "shortUrls.data" properties.
Therefore, for this parameter you specify a string array of @("shortUrls", "data").

In other words, using this function for the short-urls endpoint results in the below object if there are two pages worth of data returned:

    Invoke-ShlinkRestMethod -Endpoint 'short-urls'

    shortUrls
    ---------
    @{data=System.Object\[\]; pagination=}
    @{data=System.Object\[\]; pagination=}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShlinkServer
The URL of your Shlink server (including schema).
For example "https://example.com".
It is not required to use this parameter for every use of this function.
When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShlinkApiKey
A SecureString object of your Shlink server's API key.
It is not required to use this parameter for every use of this function.
When it is used once for any of the functions in the PSShlink module, its value is retained throughout the life of the PowerShell session and its value is only accessible within the module's scope.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### This function does not accept pipeline input.
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
