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

```
Set-ShlinkUrl [-ShortCode] <String[]> [[-LongUrl] <String>] [[-Tags] <String[]>] [[-ValidSince] <DateTime>]
 [[-ValidUntil] <DateTime>] [[-MaxVisits] <Int32>] [[-Title] <String>] [[-Domain] <String>] [-DoNotValidateUrl]
 [[-Crawlable] <Boolean>] [[-ShlinkServer] <String>] [[-ShlinkApiKey] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Update an existing short code on the Shlink server.

## EXAMPLES

### EXAMPLE 1
```
Set-ShlinkUrl -ShortCode "profile" -LongUrl "https://github.com/codaamok" -ValidSince (Get-Date "2020-11-01") -ValidUntil (Get-Date "2020-11-30") -MaxVisits 99
```

Update the existing short code "profile", associated with the default domain of the Shlink server, to point to URL "https://github.com/codaamok".
The link will only be valid for November 2020.
The link will only work for 99 visits.

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
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LongUrl
The new long URL to associate with the existing short code.

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

### -Tags
The name of one or more tags to associate with the existing short code.
Due to the architecture of Shlink's REST API, this parameter can only be used in its own parameter set.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidSince
Define a new "valid since" date with the existing short code.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidUntil
Define a new "valid until" date with the existing short code.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxVisits
Set a new maximum visits threshold for the existing short code.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Define a title with the new short code.

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

### -Domain
The domain which is associated with the short code you wish to update.
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DoNotValidateUrl
Disables long URL validation while creating the short code.

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

### -Crawlable
Set short URLs as crawlable, making them be listed in the robots.txt as Allowed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
Position: 10
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
Position: 11
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
