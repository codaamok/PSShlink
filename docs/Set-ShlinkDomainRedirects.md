---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Set-ShlinkDomainRedirects

## SYNOPSIS
Sets the URLs that you want a visitor to get redirected to for "not found" URLs for a specific domain.

## SYNTAX

### BaseUrlRedirect (Default)
```
Set-ShlinkDomainRedirects -Domain <String> -BaseUrlRedirect <String> [-Regular404Redirect <String>]
 [-InvalidShortUrlRedirect <String>] [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>]
 [<CommonParameters>]
```

### InvalidShortUrlRedirect
```
Set-ShlinkDomainRedirects -Domain <String> [-BaseUrlRedirect <String>] [-Regular404Redirect <String>]
 -InvalidShortUrlRedirect <String> [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

### Regular404Redirect
```
Set-ShlinkDomainRedirects -Domain <String> [-BaseUrlRedirect <String>] -Regular404Redirect <String>
 [-InvalidShortUrlRedirect <String>] [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>]
 [<CommonParameters>]
```

## DESCRIPTION
Sets the URLs that you want a visitor to get redirected to for "not found" URLs for a specific domain.

## EXAMPLES

### EXAMPLE 1
```
Set-ShlinkDomainRedirects -Domain "example.com" -BaseUrlRedirect "https://someotheraddress.com"
```

Modifies the redirect setting 'BaseUrlRedirect' of example.com to redirect to "https://someotheraddress.com".

## PARAMETERS

### -Domain
The domain (excluding schema) in which you would like to modify the redirects of.
For example, "example.com" is an acceptable value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaseUrlRedirect
Modify the 'BaseUrlRedirect' redirect setting of the domain.

```yaml
Type: String
Parameter Sets: BaseUrlRedirect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: InvalidShortUrlRedirect, Regular404Redirect
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Regular404Redirect
Modify the 'Regular404Redirect' redirect setting of the domain.

```yaml
Type: String
Parameter Sets: BaseUrlRedirect, InvalidShortUrlRedirect
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: Regular404Redirect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InvalidShortUrlRedirect
Modify the 'InvalidShortUrlRedirect' redirect setting of the domain.

```yaml
Type: String
Parameter Sets: BaseUrlRedirect, Regular404Redirect
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: InvalidShortUrlRedirect
Aliases:

Required: True
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
## NOTES

## RELATED LINKS
