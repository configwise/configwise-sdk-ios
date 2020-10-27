# ConfigWiseSDK

``` swift
public class ConfigWiseSDK
```

## Properties

### `fileLogger`

``` swift
let fileLogger
```

### `version`

``` swift
var version: String
```

### `versionName`

``` swift
var versionName: String?
```

### `versionBuildNumber`

``` swift
var versionBuildNumber: String?
```

### `signOutNotification`

``` swift
let signOutNotification
```

### `conceptCreatedNotification`

``` swift
let conceptCreatedNotification
```

### `conceptUpdatedNotification`

``` swift
let conceptUpdatedNotification
```

### `conceptDeletedNotification`

``` swift
let conceptDeletedNotification
```

### `componentCreatedNotification`

``` swift
let componentCreatedNotification
```

### `componentUpdatedNotification`

``` swift
let componentUpdatedNotification
```

### `componentDeletedNotification`

``` swift
let componentDeletedNotification
```

### `appListItemCreatedNotification`

``` swift
let appListItemCreatedNotification
```

### `appListItemUpdatedNotification`

``` swift
let appListItemUpdatedNotification
```

### `appListItemDeletedNotification`

``` swift
let appListItemDeletedNotification
```

### `materialCreatedNotification`

``` swift
let materialCreatedNotification
```

### `materialUpdatedNotification`

``` swift
let materialUpdatedNotification
```

### `materialDeletedNotification`

``` swift
let materialDeletedNotification
```

### `sceneCreatedNotification`

``` swift
let sceneCreatedNotification
```

### `sceneUpdatedNotification`

``` swift
let sceneUpdatedNotification
```

### `sceneDeletedNotification`

``` swift
let sceneDeletedNotification
```

### `unsupportedAppVersionNotification`

``` swift
let unsupportedAppVersionNotification
```

### `componentProgressNotification`

``` swift
let componentProgressNotification
```

### `materialProgressNotification`

``` swift
let materialProgressNotification
```

### `sceneProgressNotification`

``` swift
let sceneProgressNotification
```

### `isB2C`

``` swift
var isB2C: Bool
```

### `isB2B`

``` swift
var isB2B: Bool
```

## Methods

### `isRootGroup(_:)`

``` swift
public class func isRootGroup(_ group: String) -> Bool
```

### `reconnect(appName:appVersion:)`

``` swift
public class func reconnect(appName: String? = nil, appVersion: String? = nil)
```

### `initialize(_:)`

``` swift
public class func initialize(_ options: [SdkInitializeOption: Any?])
```
