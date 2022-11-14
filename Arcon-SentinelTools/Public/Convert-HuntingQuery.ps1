function Convert-HuntingQuery {
    <#
    .SYNOPSIS
    Converts yaml files from given Path to json files (ARM) as hunting queries
    .DESCRIPTION
    Converts yaml files from given Path to json files (ARM) as hunting queries
    .PARAMETER Path
    Provide Path to read base yaml files
    .PARAMETER DestinationPath
    Provide Output Path where json output will be saved

    .EXAMPLE
    Convert-HuntingQuery -Path .\RAWSamples\Hunting -DestinationPath .\ConvertedSamples\Hunting
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
        Write-Verbose -Message ('Parsing yaml files from [{0}] to generate hunting query' -f $Path)
        foreach($parserYaml in $FilesToParse) {
            Write-Verbose -Message ('    Converting file [{0}]' -f $parserYaml.BaseName)
            $outputFilePath = Join-Path -Path $DestinationPath -ChildPath ('{0}.json' -f $parserYaml.BaseName)
            Convert-HuntingQueryFromYamlToArm $parserYaml.FullName $outputFilePath
            Write-Verbose -Message ('    Generated hunting query file [{0}]' -f $outputFilePath)
        }
    }
    else {
        Write-Verbose -Message ('There were no yaml files in given path [{0}]' -f $Path)
    }    
}