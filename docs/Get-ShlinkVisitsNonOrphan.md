---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Get-ShlinkVisitsNonOrphan

## SYNOPSIS
Get the list of visits to invalid short URLs, the base URL or any other 404.

## SYNTAX

```
Get-ShlinkVisitsNonOrphan [[-StartDate] <DateTime>] [[-EndDate] <DateTime>] [-ExcludeBots]
 [[-ShlinkServer] <String>] [[-ShlinkApiKey] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Get the list of visits to invalid short URLs, the base URL or any other 404.

## EXAMPLES

### EXAMPLE 1
```
Get-ShlinkVisitsOrphan
```

Get the list of visits to invalid short URLs, the base URL or any other 404.

### EXAMPLE 2
```
Get-ShlinkVisitsOrphan -StartDate (Get-Date "2020-11-01") -EndDate (Get-Date "2020-12-01") -ExcludeBots
```

Get the list of visits to invalid short URLs, the base URL or any other 404, for the whole of November and excluding bots/crawlers.

## PARAMETERS

### -StartDate
A datetime object to filter the visit data where the start date is equal or greater than this value.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
A datetime object to filter the visit data where its end date is equal or less than this value.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeBots
Exclude visits from bots or crawlers.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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
Position: 3
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
Position: 4
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
