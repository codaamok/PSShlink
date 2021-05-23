---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Get-ShlinkVisits

## SYNOPSIS
Get details of visits for a Shlink server, short codes or tags.

## SYNTAX

### Server (Default)
```
Get-ShlinkVisits [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### ShortCode
```
Get-ShlinkVisits -ShortCode <String> [-Domain <String>] [-StartDate <DateTime>] [-EndDate <DateTime>]
 [-ExcludeBots] [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### Tag
```
Get-ShlinkVisits -Tag <String> [-Domain <String>] [-StartDate <DateTime>] [-EndDate <DateTime>] [-ExcludeBots]
 [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Get details of visits for a Shlink server, short codes or tags.

## EXAMPLES

### EXAMPLE 1
```
Get-ShlinkVists
```

Returns the overall visit count for your Shlink server

### EXAMPLE 2
```
Get-ShlinkVisits -ShortCode "profile"
```

Returns all visit data associated with the short code "profile"

### EXAMPLE 3
```
Get-ShlinkVisits -Tag "oldwebsite"
```

Returns all the visit data for all short codes asociated with the tag "oldwebsite"

### EXAMPLE 4
```
Get-ShlinkVisits -ShortCode "profile" -StartDate (Get-Date "2020-11-01") -EndDate (Get-Date "2020-12-01")
```

Returns all visit data associated with the short code "profile" for the whole of November 2020

## PARAMETERS

### -ShortCode
The name of the short code you wish to return the visits data for.
For example, if the short URL is "https://example.com/new-url" then the short code is "new-url".

```yaml
Type: String
Parameter Sets: ShortCode
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
The name of the tag you wish to return the visits data for.

```yaml
Type: String
Parameter Sets: Tag
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
Parameter Sets: ShortCode, Tag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
A datetime object to filter the visit data where the start date is equal or greater than this value.

```yaml
Type: DateTime
Parameter Sets: ShortCode, Tag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
A datetime object to filter the visit data where its end date is equal or less than this value.

```yaml
Type: DateTime
Parameter Sets: ShortCode, Tag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeBots
Exclude visits from bots or crawlers.

```yaml
Type: SwitchParameter
Parameter Sets: ShortCode, Tag
Aliases:

Required: False
Position: Named
Default value: False
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
## NOTES

## RELATED LINKS
