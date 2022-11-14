# Arcon-SentinelTools
Tools to help in Sentinel automation - parses files to required by Sentinel input

This module uses functions from https://github.com/SentinelCICD/RepositoriesSampleContent.

As there was no help nor description I've decided to quick-draft this module to help in converting files.

This module will convert yaml files for:
- Automation Rules
- Detections
- Hunting Queries
- Playbooks
- Workbooks

into their respective json (arm) form. 

This module goes with some sample files taken from:
- https://github.com/SentinelCICD/RepositoriesSampleContent
- https://github.com/DanielChronlund/DCSecurityOperations 


Download the module and extract it to location you choose. 

To have this module operate properly you need to install Powershall-yaml module first

```powershell
Install-Module PowerShell-yaml

```
Then import the module and list available commands

```powershell
Import-Module .\Arcon-SentinelTools\Arcon-SentinelTools.psm1 -force
Get-Command -module Arcon-SentinelTools
```

Change location to where your raw yaml files are located. In this example it's the module location

```powershell
Set-Location C:\Repos\Arcon-SentinelTools
```

Then run these function to convert respective files to their destination form:
```powershell
Convert-Detection -Path .\RAWSamples\Detections\ -DestinationPath .\ConvertedSamples\Detections\ -Verbose
Convert-HuntingQuery -Path .\RAWSamples\Hunting\ -DestinationPath .\ConvertedSamples\Hunting\ -Verbose
Convert-Workbook -Path .\RAWSamples\Workbook\ -DestinationPath .\ConvertedSamples\Workbook\ -Verbose
```

Then you need to copy those converted files to your Sentinel CI/CD repository, e.g.:

```powershell
Copy-Item -Path .\ConvertedSamples\* -Recurse -Destination C:\Repos\Arcon-Soc\SentinelContent\
Copy-Item -Path .\ConvertedSamples\Detections\* -Recurse -Destination C:\Repos\Arcon-Soc\SentinelContent\Detections\ -Force\
Copy-Item -Path .\ConvertedSamples\Workbook\* -Recurse -Destination C:\Repos\Arcon-Soc\SentinelContent\Workbook\ -Force
```