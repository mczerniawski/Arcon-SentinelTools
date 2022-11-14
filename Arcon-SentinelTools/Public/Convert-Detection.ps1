function Convert-Detection {
    <#
    .SYNOPSIS
    Converts yaml files from given Path to json files (ARM) as detection (analytics rule)
    .DESCRIPTION
    Converts yaml files from given Path to json files (ARM) as detection (analytics rule)
    .PARAMETER Path
    Provide Path to read base yaml files
    .PARAMETER DestinationPath
    Provide Output Path where json output will be saved

    .EXAMPLE
    Convert-Detection -Path .\RAWSamples\Detection -DestinationPath .\ConvertedSamples\Detection
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
        Write-Verbose -Message ('Parsing yaml files from [{0}] to generate detection (analytics)' -f $Path)
        foreach($parserYaml in $FilesToParse) {
            Write-Verbose -Message ('    Converting file [{0}]' -f $parserYaml.BaseName)
            $outputFilePath = Join-Path -Path $DestinationPath -ChildPath ('{0}.json' -f $parserYaml.BaseName)
            Convert-DetectionRuleFromYamlToArm $parserYaml.FullName $outputFilePath
            Write-Verbose -Message ('    Generated detection (analytics) file [{0}]' -f $outputFilePath)
        }
    }
    else {
        Write-Verbose -Message ('There were no yaml files in given path [{0}]' -f $Path)
    }    
}