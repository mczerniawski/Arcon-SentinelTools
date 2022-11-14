function Test-ISO8601Format($field) {
    if ($field.IndexOf("D") -ne -1) {
        return "P$field"
    }
    else {
        "PT$field"
    }
}