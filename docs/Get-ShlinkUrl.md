---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Get-ShlinkUrl

## SYNOPSIS
Get details of all short codes, or just one.

## SYNTAX

### ListShortUrls (Default)
```
Get-ShlinkUrl [-SearchTerm <String>] [-Tags <String[]>] [-OrderBy <String>] [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### ParseShortCode
```
Get-ShlinkUrl -ShortCode <String> [-Domain <String>] [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>]
 [<CommonParameters>]
```

## DESCRIPTION
Get details of all short codes, or just one.
Various filtering options are available from the API to ambigiously search for short codes.

## EXAMPLES

### EXAMPLE 1
```
Get-ShlinkUrl
```

Returns all short codes with no filtering applied.

### EXAMPLE 2
```
Get-ShlinkUrl -ShortCode "profile"
```

Returns the short code "profile".

### EXAMPLE 3
```
Get-ShlinkUrl -ShortCode "profile" -Domain "example.com"
```

Returns the short code "profile" using the domain "example.com".
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

### EXAMPLE 4
```
Get-ShlinkUrl -Tags "oldwebsite", "evenolderwebsite" -OrderBy "dateCreated"
```

Returns short codes which are associated with the tags "oldwebsite" and "evenolderwebsite".
Ordered by the dateCreated property in ascending order.

### EXAMPLE 5
```
Get-ShlinkUrl -StartDate (Get-Date "2020-10-25 11:00:00")
```

Returns short codes which have a start date of 25th October 2020 11:00:00 AM or newer.
If a start date was not configured for the short code(s), this filters on the dateCreated property.

### EXAMPLE 6
```
Get-ShlinkUrl -SearchTerm "microsoft"
```

Returns the short codes which match the search term "microsoft".

## PARAMETERS

### -ShortCode
The name of the short code you wish to search for.
For example, if the short URL is "https://example.com/new-url" then the short code is "new-url".

```yaml
Type: String
Parameter Sets: ParseShortCode
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
The domain (excluding schema) associated with the short code you wish to search for.
For example, "example.com" is an acceptable value. 
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

```yaml
Type: String
Parameter Sets: ParseShortCode
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchTerm
The search term to search for a short code with.

```yaml
Type: String
Parameter Sets: ListShortUrls
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
One or more tags can be passed to find short codes using said tag(s).

```yaml
Type: String[]
Parameter Sets: ListShortUrls
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrderBy
Order the results returned by "longUrl", "shortCode", "dateCreated", or "visits".
The default sort order is in ascending order.

```yaml
Type: String
Parameter Sets: ListShortUrls
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
A datetime object to search for short codes where its start date is equal or greater than this value. 
If a start date is not configured for the short code(s), this filters on the dateCreated property.

```yaml
Type: DateTime
Parameter Sets: ListShortUrls
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
A datetime object to search for short codes where its end date is equal or less than this value.

```yaml
Type: DateTime
Parameter Sets: ListShortUrls
Aliases:

Required: False
Position: Named
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
Position: Named
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
Position: Named
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
### Objects have a PSTypeName of 'PSShlink'.
## NOTES

## RELATED LINKS
