<#
    .SYNOPSIS
        Map certain target-directories to defined paths.
    .DESCRIPTION
        Paths and targets are defined within the config.psd1 file, that is read upon execution.
        Requires to be run as administrator to create links.
#>


# ToDo: # Requires -RunAsAdministrator

<#
    .SYNOPSIS
        Initializes required constants and defines for the script.
#>
function Initialize-Constants() {
    # configuration keys
    Set-Variable -Name KEY_LINK -Option ReadOnly -Value 'link' -Scope script -Force
    Set-Variable -Name KEY_TARGET -Option ReadOnly -Value 'target' -Scope script -Force
    Set-Variable -Name KEY_SKIP_UPDATE -Option ReadOnly -Value 'skip_update' -Scope script -Force
    Set-Variable -Name KEY_HIDE_LINK -Option ReadOnly -Value 'hide_link' -Scope script -Force
    # functional values
    Set-Variable -Name GET_USER_PROFILE -Option ReadOnly -Value 'get:user_profile' -Scope script -Force
    # Write-Host 'Done!'
}

<#
    .SYNOPSIS
        Reads the configuration from the local config.psd1
    .DESCRIPTION
        Configuration-file format is psd1. For details on psd1-files see the following link.
    .LINK
        https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-powershelldatafile?view=powershell-7.3
#>
function Read-Configuration {
    param (
        # Configuration data file to used to specify directory mappings.
        [Parameter(Mandatory)]
        [ValidateScript({
                if (!(Test-Path $_ -PathType leaf)) {
                    throw [System.IO.FileNotFoundException]::new("Config file not found: $_")
                } else {
                    return $true
                }
            })]
        [string] $ConfigFile
    )
    # ToDo: make private
    Write-Host "Using configuration from $ConfigFile."
    [hashtable] $configurationTable = Import-PowerShellDataFile $ConfigFile
    return $configurationTable
}

<#
    .SYNOPSIS
        Runs the link creation logic.
    .DESCRIPTION
        ToDo: ...
#>
function Update-DirectoryLinksFromHashTable {
    param (
        # Configuration data hashtable to create the directory mappings.
        [Parameter(Mandatory)]
        [hashtable] $ConfigurationTable
    )
    # ToDo: make private
    # ToDo: link-generation logic here

    # function Initialize-FleetConfigDir {
    #     $fleetPath = 'c:\users\mj\.fleet'
    #     $fleetTarget = 's:\My Drive\sync\jetbrains\fleet\'
    #     function Set-FleetSymbolicLink {

    #         Write-Output 'Routing fleet config to $fleetTarget'
    #         New-Item -ItemType SymbolicLink -Path $fleetPath -Target $fleetTarget
    #         # hide the link from user-sight
    #         attrib $fleetPath +H /L
    #     }
    #     # preparation
    #     Write-Output 'Fixing mj user-directories first...'
    #     & 's:\My Drive\setup\createMjUserDirLinks.cmd'
    #     # actual function
    #     if (Test-Path -Path $fleetPath) {
    #         $fleetDir = Get-Item .\.fleet\ -Force
    #         if (($fleetDir.Attributes -band [System.IO.FileAttributes]::Directory) `
    #                 -eq [System.IO.FileAttributes]::Directory) {
    #             Write-Output "Removing original $fleetPath ..."
    #             Remove-Item $fleetDir -Recurse -Force
    #             Set-FleetSymbolicLink
    #         }
    #     } else {
    #         Set-FleetSymbolicLink
    #     }
    # }

    $ConfigurationTable.Values | ForEach-Object {
        $test = $_.contains($KEY_TARGET)
        Write-Host "$test $($_.$KEY_TARGET) $($_.$KEY_LINK) $($_.$KEY_SKIP_UPDATE)"
    }
}

<#
    .SYNOPSIS
        Invokes the Update-DiectoryLinks directory mapper.
    .DESCRIPTION
        Configuration-file format is psd1. Can be specified via -ConfigFile parameter.
#>
function Update-SymbolicLinks {
    param (
        # Configuration data file to used to specify directory mappings.
        [string] $ConfigFile = (Join-Path -Path $PSScriptRoot -ChildPath 'config.psd1')

    )
    # bootstrap the script
    Initialize-Constants
    # read configuration file
    $configurationTable = Read-Configuration($ConfigFile)
    # execute!
    Update-DirectoryLinksFromHashTable($configurationTable)
}
