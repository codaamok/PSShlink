---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Get-ShlinkTags

## SYNOPSIS
Returns the list of all tags used in any short URL, including stats and ordered by name.

## SYNTAX

```
Get-ShlinkTags [[-SearchTerm] <String>] [[-ShlinkServer] <String>] [[-ShlinkApiKey] <SecureString>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the list of all tags used in any short URL, including stats and ordered by name.

## EXAMPLES

### EXAMPLE 1
```
Get-ShlinkTags
```

Returns the list of all tags used in any short URL, including stats and ordered by name.

### EXAMPLE 2
```
Get-ShlinkTags -SearchTerm "pwsh"
```

Returns the list of all tags used in any short URL, including stats and ordered by name, where those match the term "pwsh" by name of tag.

## PARAMETERS

### -SearchTerm
A query used to filter results by searching for it on the tag name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
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
Position: 3
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
