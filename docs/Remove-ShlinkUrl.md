---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Remove-ShlinkUrl

## SYNOPSIS
Removes a short code from the Shlink server

## SYNTAX

```
Remove-ShlinkUrl [-ShortCode] <String[]> [[-Domain] <String>] [[-ShlinkServer] <String>]
 [[-ShlinkApiKey] <SecureString>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a short code from the Shlink server

## EXAMPLES

### EXAMPLE 1
```
Remove-ShlinkUrl -ShortCode "profile" -WhatIf
```

Reports what would happen if the command was invoked, because the -WhatIf parameter is present.

### EXAMPLE 2
```
Remove-ShlinkUrl -ShortCode "profile" -Domain "example.com"
```

Removes the short code "profile" associated with the domain "example.com" from the Shlink server.

### EXAMPLE 3
```
Get-ShlinkUrl -SearchTerm "oldwebsite" | Remove-ShlinkUrl
```

Removes all existing short codes which match the search term "oldwebsite".

### EXAMPLE 4
```
"profile", "house" | Remove-ShlinkUrl
```

Removes the short codes "profile" and "house" from the Shlink instance.

## PARAMETERS

### -ShortCode
The name of the short code you wish to remove from the Shlink server.

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

### -Domain
The domain associated with the short code you wish to remove from the Shlink server.
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

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
### Used for the -ShortCode parameter.
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
