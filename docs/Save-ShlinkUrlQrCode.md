---
external help file: PSShlink-help.xml
Module Name: PSShlink
online version:
schema: 2.0.0
---

# Save-ShlinkUrlQrCode

## SYNOPSIS
Save a QR code to disk for a short code.

## SYNTAX

### InputObject
```
Save-ShlinkUrlQrCode -InputObject <PSObject[]> [-Path <String>] [-Size <Int32>] [-Format <String>]
 [<CommonParameters>]
```

### SpecifyProperties
```
Save-ShlinkUrlQrCode -ShortCode <String> [-Domain <String>] [-Path <String>] [-Size <Int32>] [-Format <String>]
 [-ShlinkServer <String>] [-ShlinkApiKey <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
Save a QR code to disk for a short code.
The default size of images is 300x300 and the default file type is png.
The default folder for files to be saved to is $HOME\Downloads.
The naming convention for the saved files is as follows: ShlinkQRCode_\<shortCode\>_\<domain\>_\<size\>.\<format\>

## EXAMPLES

### EXAMPLE 1
```
Save-ShlinkUrlQrCode -ShortCode "profile" -Domain "example.com" -Size 1000 -Format svg -Path "C:\temp"
```

Saves a QR code to disk in C:\temp named "ShlinkQRCode_profile_example-com_1000.svg".
It will be saved as 1000x1000 pixels and of SVG type.

### EXAMPLE 2
```
Get-ShlinkUrl -SearchTerm "someword" | Save-ShlinkUrlQrCode -Path "C:\temp"
```

Saves QR codes for all short URLs returned by the Get-ShlinkUrl call.
All files will be saved as the default values for size (300x300) and type (png).
All files will be saved in "C:\temp" using the normal naming convention for file names, as detailed in the description.

## PARAMETERS

### -InputObject
{{ Fill InputObject Description }}

```yaml
Type: PSObject[]
Parameter Sets: InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ShortCode
{{ Fill ShortCode Description }}

```yaml
Type: String
Parameter Sets: SpecifyProperties
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
{{ Fill Domain Description }}

```yaml
Type: String
Parameter Sets: SpecifyProperties
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{ Fill Path Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "{0}\Downloads" -f $home
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size
{{ Fill Size Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 300
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format
{{ Fill Format Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Png
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShlinkServer
{{ Fill ShlinkServer Description }}

```yaml
Type: String
Parameter Sets: SpecifyProperties
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShlinkApiKey
{{ Fill ShlinkApiKey Description }}

```yaml
Type: SecureString
Parameter Sets: SpecifyProperties
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

### System.Management.Automation.PSObject[]
### Expects PSObjects with PSTypeName of 'PSTypeName', typically from Get-ShlinkUrl.
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS
