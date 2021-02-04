---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Set-ShlinkUrl

## SYNOPSIS
Update an existing short code on the Shlink server.

## SYNTAX

### EditUrl
```
Set-ShlinkUrl -ShortCode <String[]> -LongUrl <String> [-Domain <String>] [-DoNotValidateUrl]
 [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### EditUrlTag
```
Set-ShlinkUrl -ShortCode <String[]> -Tags <String[]> [-Domain <String>] [-ShlinkServer <String>]
 [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### EditValidSince
```
Set-ShlinkUrl -ShortCode <String[]> -ValidSince <DateTime> [-Domain <String>] [-ShlinkServer <String>]
 [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### EditValidUntil
```
Set-ShlinkUrl -ShortCode <String[]> -ValidUntil <DateTime> [-Domain <String>] [-ShlinkServer <String>]
 [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### MaxVisits
```
Set-ShlinkUrl -ShortCode <String[]> -MaxVisits <Int32> [-Domain <String>] [-ShlinkServer <String>]
 [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Update an existing short code on the Shlink server.
It is only possible to update one property for a short code in a single call of this function.

## EXAMPLES

### EXAMPLE 1
```
Set-ShlinkUrl -ShortCode "profile" -LongUrl "https://github.com/codaamok"
```

Update the existing short code "profile", associated with the default domain of the Shlink server, to point to URL "https://github.com/codaamok".

### EXAMPLE 2
```
Set-ShlinkUrl -ShortCode "profile" -Tags "powershell","pwsh"
```

Update the existing short code "profile" to have the tags "powershell" and "pwsh" associated with it.

### EXAMPLE 3
```
Get-ShlinkUrl -SearchTerm "preview" | Set-ShlinkUrl -Tags "preview"
```

Updates all existing short codes which match the search term "preview" to have the tag "preview".

## PARAMETERS

### -ShortCode
The name of the short code you wish to update.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LongUrl
The new long URL to associate with the existing short code.

```yaml
Type: String
Parameter Sets: EditUrl
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
The name of one or more tags to associate with the existing short code.
Due to the architecture of Shlink's REST API, this parameter can only be used in its own parameter set.

```yaml
Type: String[]
Parameter Sets: EditUrlTag
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidSince
Define a new "valid since" date with the existing short code.

```yaml
Type: DateTime
Parameter Sets: EditValidSince
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidUntil
Define a new "valid until" date with the existing short code.

```yaml
Type: DateTime
Parameter Sets: EditValidUntil
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxVisits
Set a new maximum visits threshold for the existing short code.

```yaml
Type: Int32
Parameter Sets: MaxVisits
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
The domain which is associated with the short code you wish to update.
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

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

### -DoNotValidateUrl
{{ Fill DoNotValidateUrl Description }}

```yaml
Type: SwitchParameter
Parameter Sets: EditUrl
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

### System.String[]
### Used for the -ShortCode parameter.
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
