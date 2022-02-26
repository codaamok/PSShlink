---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Remove-ShlinkTag

## SYNOPSIS
Remove a tag from an existing Shlink server.

## SYNTAX

```
Remove-ShlinkTag [-Tag] <String[]> [[-ShlinkServer] <String>] [[-ShlinkApiKey] <SecureString>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a tag from an existing Shlink server.

## EXAMPLES

### EXAMPLE 1
```
Remove-ShlinkTag -Tags "oldwebsite" -WhatIf
```

Reports what would happen if the command was invoked, because the -WhatIf parameter is present.

### EXAMPLE 2
```
Remove-ShlinkTag -Tags "oldwebsite", "newwebsite"
```

Removes the following tags from the Shlink server: "oldwebsite", "newwebsite"

### EXAMPLE 3
```
"tag1","tag2" | Remove-ShlinkTag
```

Removes "tag1" and "tag2" from your Shlink instance.

### EXAMPLE 4
```
Get-ShlinkUrl -ShortCode "profile" | Remove-ShlinkTag
```

Removes all the tags which are associated with the short code "profile" from the Shlink instance.

## PARAMETERS

### -Tag
Name(s) of the tag(s) you want to remove.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
### Used for the -Tags parameter.
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
