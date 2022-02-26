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
 [-Margin <Int32>] [-ErrorCorrection <String>] [-RoundBlockSize <Boolean>] [-PassThru] [<CommonParameters>]
```

### SpecifyProperties
```
Save-ShlinkUrlQrCode -ShortCode <String> [-Domain <String>] [-Path <String>] [-Size <Int32>] [-Format <String>]
 [-Margin <Int32>] [-ErrorCorrection <String>] [-RoundBlockSize <Boolean>] [-ShlinkServer <String>]
 [-ShlinkApiKey <SecureString>] [-PassThru] [<CommonParameters>]
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
The name of the short code you wish to create a QR code with.

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
The domain which is associated with the short code you wish to create a QR code with.
This is useful if your Shlink instance is responding/creating short URLs for multiple domains.

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
The path where you would like the save the QR code. 
If omitted, the default is the Downloads directory of the runner user's $Home environment variable. 
If the directory doesn't exist, it will be created.

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
Specify the pixel width you want for your generated shortcodes.
The same value will be applied to the height.
If omitted, the default configuration of your Shlink server is used.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format
Specify whether you would like your QR codes to save as .png or .svg files.
If omitted, the default configuration of your Shlink server is used.

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

### -Margin
Specify the margin/whitespace around the QR code image in pixels.
If omitted, the default configuration of your Shlink server is used.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorCorrection
Specify the level of error correction you would like in the QR code.
Choose from L for low, M for medium, Q for quartile, or H for high.
If omitted, the default configuration of your Shlink server is used.

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

### -RoundBlockSize
Allows to disable block size rounding, which might reduce the readability of the QR code, but ensures no extra margin is added.
Possible values are true or false boolean types.
If omitted, the default configuration of your Shlink server is used.

```yaml
Type: Boolean
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
Parameter Sets: SpecifyProperties
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
Parameter Sets: SpecifyProperties
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns a System.IO.FileSystemInfo object of each QR image file it creates

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject[]
### Expects PSObjects with PSTypeName of 'PSTypeName', typically from Get-ShlinkUrl.
## OUTPUTS

### System.IO.FileSystemInfo
## NOTES

## RELATED LINKS
