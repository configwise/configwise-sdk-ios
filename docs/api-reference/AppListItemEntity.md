# AppListItemEntity

``` swift
public class AppListItemEntity: CatalogAwareEntity, PFSubclassing
```

## Inheritance

[`CatalogAwareEntity`](CatalogAwareEntity), `PFSubclassing`

## Properties

### `parent`

``` swift
var parent: AppListItemEntity?
```

### `component`

``` swift
var component: ComponentEntity?
```

### `type`

``` swift
var type: AppListItemType
```

### `label`

``` swift
var label: String
```

### `desc`

``` swift
var desc: String
```

### `imagePath`

``` swift
var imagePath: String?
```

### `enabled`

``` swift
var enabled: Bool
```

### `showPreview`

``` swift
var showPreview: Bool
```

### `textColor`

``` swift
var textColor: UIColor?
```

### `index`

``` swift
var index: Int
```

### `automaticDownloadingVariances`

``` swift
var automaticDownloadingVariances: Bool
```

### `isOverlayImage`

``` swift
var isOverlayImage: Bool
```

### `isNavigationItem`

``` swift
var isNavigationItem: Bool
```

### `isMainProduct`

``` swift
var isMainProduct: Bool
```

### `imageUrl`

``` swift
var imageUrl: URL?
```

## Methods

### `isImageExist()`

``` swift
public func isImageExist() -> Bool
```

### `obtainImageData(block:)`

``` swift
public func obtainImageData(block: @escaping (Data?, Error?) -> Void)
```

### `parseClassName()`

``` swift
public static func parseClassName() -> String
```

### `spawn(_:)`

``` swift
public class func spawn(_ other: AppListItemEntity) -> AppListItemEntity
```
