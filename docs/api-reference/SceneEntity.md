# SceneEntity

``` swift
public class SceneEntity: CatalogAwareEntity, PFSubclassing
```

## Inheritance

[`CatalogAwareEntity`](CatalogAwareEntity), `PFSubclassing`

## Properties

### `lightingEnvironment`

``` swift
var lightingEnvironment: ScnMaterialPropertyEntity?
```

### `rgbHexCodes`

``` swift
var rgbHexCodes: [String: String]
```

### `uiColors`

``` swift
var uiColors: [String: UIColor]
```

### `textureFilePaths`

``` swift
var textureFilePaths: [String: String]
```

### `textureFileUrls`

``` swift
var textureFileUrls: [String: URL]
```

## Methods

### `parseClassName()`

``` swift
public static func parseClassName() -> String
```

### `getTextureFileDatas(block:)`

``` swift
public func getTextureFileDatas(block: @escaping ([String: Data]) -> Void)
```

### `getTextureImages(block:)`

``` swift
public func getTextureImages(block: @escaping ([String: UIImage]) -> Void)
```

### `getPaletteImage(block:)`

``` swift
public func getPaletteImage(block: @escaping (UIImage?) -> Void)
```

### `getScnLightingEnvironment(block:)`

``` swift
public func getScnLightingEnvironment(block: @escaping (SCNMaterialProperty) -> Void)
```
