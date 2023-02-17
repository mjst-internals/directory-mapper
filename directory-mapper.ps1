<#
    .SYNOPSIS
        Map certain target-directories to defined paths.
    .DESCRIPTION
        Paths and targets are defined within the config.psd1 file, that is read upon execution.
#>


<#
    .SYNOPSIS
        Initializes required constants and defines for the script.
#>
function Initialize-Constants() {
    if (!$FUNCVALUE_USERPROFILE) {
        Set-Variable -Name FUNCVALUE_USERPROFILE -Option Constant -Value 'env:userprofile'
    }
    if (!$KEY_PATH) {
        Set-Variable -Name KEY_PATH -Option Constant -Value 'path'
    }
    if (!$KEY_TARGET) {
        Set-Variable -Name KEY_TARGET -Option Constant -Value 'target'
    }
    if (!$KEY_TRY_RECREATE) {
        Set-Variable -Name KEY_TRY_RECREATE -Option Constant -Value 'try_recreate'
    }
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
        Write-Output "$test $($_.$KEY_TARGET) $($_.$KEY_PATH) $($_.$KEY_TRY_RECREATE)"
    }
}

Initialize-Constants
# fixme: remove!

Read-Configuration
