@{
    'map hugo to xyz' = @{
        path = 'env:USERPROFILE\test'
        target = 'f:\temp'
        'try_recreate' = $false
    }
    secondMappingAnyName = @{
        path = 'env:USERPROFILE\test'
        taRget = 'f:\temp'
        try_recreate = $true
    }
    whateverMappingAnyName = @{
        path = 'f:\temp\test'
        taRget = 'f:\temp\something'
    }
}
