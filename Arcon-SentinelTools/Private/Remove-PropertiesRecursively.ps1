function Remove-PropertiesRecursively ($resourceObj) {
    foreach ($prop in $resourceObj.PsObject.Properties) {
        $key = $prop.Name
        $val = $prop.Value
        if ($null -eq $val) {
            $resourceObj.PsObject.Properties.Remove($key)
        }
        elseif ($val -is [System.Object[]]) {
            if ($val.Count -eq 0) {
                $resourceObj.PsObject.Properties.Remove($key)
            }
            else {
                foreach ($item in $val) {
                    $itemIndex = $val.IndexOf($item)
                    $resourceObj.$key[$itemIndex] = $(Remove-PropertiesRecursively $val[$itemIndex])
                }
            }
        }
        else {
            if ($val -is [PSCustomObject]) {
                if ($($val.PsObject.Properties).Count -eq 0) {
                    $resourceObj.PsObject.Properties.Remove($key)
                }
                else {
                    $resourceObj.$key = $(Remove-PropertiesRecursively $val)
                    if ($($resourceObj.$key.PsObject.Properties).Count -eq 0) {
                        $resourceObj.PsObject.Properties.Remove($key)
                    }
                }
            }
        }
    }
    $resourceObj
}
