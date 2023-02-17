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
    $data = Import-PowerShellDataFile $PSScriptRoot\config.psd1
    $data.Values | ForEach-Object {
        $test = $_.contains($KEY_TARGET)
        Write-Output "$test $($_.$KEY_TARGET) $($_.$KEY_LINK) $($_.$KEY_SKIP_UPDATE)"
    }
}

# ToDo: implement basics

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


Initialize-Constants

# fixme: remove!
Read-Configuration
