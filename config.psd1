<#
    .SYNOPSIS
        Example configuration file.
    .DESCRIPTION
        This file contains nested hash-tables. Structure is obligatory.

        Required keys:
        - link: path, representing the directory-link.
            The path will be ...
            ... renamed (with '.bak'), if it's an already existing directory.
            ... updated, if it's already a directory-link.
                ToDo: check with: Get-ChildItem | ? Target | Select-Object FullName, Target
            See 'keep_origin' option below.
        - target: link target.
            Will be created and filled with original content from directory-link (if any),
            if target doesn't already exist.

        Optional keys:
        - keep_origin: Keeps the directory-link path untouched.
        - hide_link: If $true, hides the directory-link path.

        Functional values - the following values are replaced upon link creation:
        - get:user_profile: replaced by user-profile path.
        - get:user_email: replaced by current user email address (if linked to MS-account)
        - get:onedrive_personal: replaced by path to OneDrive consumer edition.
        - get:onedrive_personal_email: replaced by OneDrive consumer account email.
        - get:onedrive_business: replaced by path to OneDrive business edition.
        - get:computername: replaced by machine name ($env:COMPUTERNAME).
        - get:temp: replaced by temp-dir environment variable.
        - get:%%: replaced by environment variable (if exists)

        Remarks:
        - All configuration values are NOT case sensitive.
        - If any of these parameters generate an error or are not compatible for file-system use,
            the link creation will be skipped.
#>

@{
    'map hugo to xyz' = @{
        link = 'env:USERPROFILE\test'
        target = 'f:\temp'
        'skip_update' = $false
    }
    secondMappingAnyName = @{
        link = 'env:USERPROFILE\test'
        taRget = 'f:\temp'
        updskip_updateate = $true
    }
    whateverMappingAnyName = @{
        link = 'f:\temp\test'
        taRget = 'f:\temp\something'
    }
    newDescriptiveName = @{
        link = 'f:\temp\get:%MYENVIRONMENTVAR%'
        taRget = 'f:\temp\something'
    }
}
