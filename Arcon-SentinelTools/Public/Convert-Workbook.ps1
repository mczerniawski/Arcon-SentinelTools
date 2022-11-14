function Convert-Workbook {
    <#
    .SYNOPSIS
    Converts yaml files from given Path to json files (ARM) as workbook
    .DESCRIPTION
    Converts yaml files from given Path to json files (ARM) as workbook
    .PARAMETER Path
    Provide Path to read base yaml files
    .PARAMETER DestinationPath
    Provide Output Path where json output will be saved

    .EXAMPLE
    Convert-Workbook -Path .\RAWSamples\Workbook -DestinationPath .\ConvertedSamples\Workbook
    #>

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = 'Provide Path to read base yaml files'
        )]
        [ValidateScript({Test-Path -Path $PSItem -PathType Container })]
        [string] $Path,

        [Parameter(
            Mandatory,
            HelpMessage = 'Provide path where json output will be saved'
        )]
        [ValidateScript({Test-Path -Path $PSItem -PathType Container })]
        [string] 
        $DestinationPath
    )

    $FilesToParse = Get-ChildItem -Path $Path -recurse -Include *.yaml
    if($FilesToParse) {
        Write-Verbose -Message ('Parsing yaml files from [{0}] to generate workbook' -f $Path)
        foreach($parserYaml in $FilesToParse) {
            Write-Verbose -Message ('    Converting file [{0}]' -f $parserYaml.BaseName)
            $outputFilePath = Join-Path -Path $DestinationPath -ChildPath ('{0}_ARM.json' -f $parserYaml.BaseName)
            Convert-WorkbooksToArm $parserYaml.FullName $outputFilePath
            Write-Verbose -Message ('    Generated workbook file [{0}]' -f $outputFilePath)
        }
    }
    else {
        Write-Verbose -Message ('There were no yaml files in given path [{0}]' -f $Path)
    }    
}
