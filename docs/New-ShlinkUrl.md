---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# New-ShlinkUrl

## SYNOPSIS
Creates a new Shlink short code on your Shlink server.

## SYNTAX

```
New-ShlinkUrl [-LongUrl] <String> [[-CustomSlug] <String>] [[-Tags] <String[]>] [[-ValidSince] <DateTime>]
 [[-ValidUntil] <DateTime>] [[-MaxVisits] <Int32>] [[-Domain] <String>] [[-ShortCodeLength] <Int32>]
 [-FindIfExists] [-DoNotValidateUrl] [[-ShlinkServer] <String>] [[-ShlinkApiKey] <SecureString>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new Shlink short code on your Shlink server.

## EXAMPLES

### EXAMPLE 1
```
New-ShlinkUrl -LongUrl "https://google.com"
```

Will generate a new short code with the long URL of "https://google.com", using your Shlink server's default for creating new short codes, and return all the information about the new short code.

### EXAMPLE 2
```
New-ShlinkUrl -LongUrl "https://google.com" -CustomSlug "mygoogle" -Tags "search-engine" -ValidSince (Get-Date "2020-11-01") -ValidUntil (Get-Date "2020-11-30") -MaxVisits 99 -FindIfExists
```

Will generate a new short code with the long URL of "https://google.com" using the custom slug "search-engine".
The default domain for the Shlink server will be used.
The link will only be valid for November 2020.
The link will only work for 99 visits.
If a duplicate short code is found using the same long URL, another is not made and instead data about the existing short code is returned.

## PARAMETERS

### -LongUrl
Define the long URL for the new short code.

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

### -CustomSlug
Define a custom slug for the new short code.

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
Associate tag(s) with the new short code.

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
Define a "valid since" date with the new short code.

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
Define a "valid until" date with the new short code.

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
Set the maximum number of visits allowed for the new short code.

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

### -Domain
Associate a domain with the new short code to be something other than the default domain. 
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

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

### -ShortCodeLength
Set the length of your new short code other than the default.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FindIfExists
Specify this switch to first search and return the data about an existing short code that uses the same long URL if one exists.

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
Position: 9
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
Position: 10
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
