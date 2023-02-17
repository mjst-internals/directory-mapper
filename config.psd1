<#
    .SYNOPSIS
        Example configuration file.
    .DESCRIPTION
        This file contains nested hash-tables. Structure is obligatory.

        Required keys:
        - link: path, representing the directory-link.
            The path will be ...
            ... renamed, if it points to an already existing directory.
            ... updated, if it is alrady a directory-link (see skip_update option below).
        - target: link target.
            Will be created and filled with content from directory-link,
            if any and if it doesn't already exist.

        Optional keys:
        - skip_update: Does not updates link, if target changed.
        - hide_link: If $true, hides the directory link.

        Functional values. The following values are replaced upon link creation:
        - get:user_profile: replaced by user-profile path.
        - get:user_email: replaced by current user email address (if linked to MS-account)
        - get:onedrive_personal: replaced by path to OneDrive consumer edition.
        - get:onedrive_personal_email: replaced by OneDrive consumer account email.
        - get:onedrive_business: replaced by path to OneDrive business edition.
        - get:computername: replaced by machine name ($env:COMPUTERNAME).
        - get:temp: replaced by temp-dir environment variable.
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
}
