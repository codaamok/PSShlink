---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Get-ShlinkServer

## SYNOPSIS
Checks the healthiness of the service, making sure it can access required resources.

## SYNTAX

```
Get-ShlinkServer [[-ShlinkServer] <String>] [<CommonParameters>]
```

## DESCRIPTION
Checks the healthiness of the service, making sure it can access required resources.

https://api-spec.shlink.io/#/Monitoring/health

## EXAMPLES

### EXAMPLE 1
```
Get-ShlinkServer
```

Returns the healthiness of the service.

## PARAMETERS

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
Position: 1
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
