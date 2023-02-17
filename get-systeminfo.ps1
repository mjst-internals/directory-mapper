<#

ToDo: OneDrive-Account from registry:
================================
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive\Accounts\Personal

ToDo: Personal account from:
=======================
 HKEY_USERS\.DEFAULT\Software\Microsoft\IdentityCRL\StoredIdentities (by UID)
 where UUID matches:

 Get-localUser | Select-Object Name,SID | Where Name -eq 'Michael'

#>