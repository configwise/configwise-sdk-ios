# MaterialEntity

``` swift
public class MaterialEntity: CatalogAwareEntity, PFSubclassing
```

## Inheritance

[`CatalogAwareEntity`](/CatalogAwareEntity), `PFSubclassing`

## Properties

### `name`

``` swift
var name: String
```

### `scnProperties`

``` swift
var scnProperties: ScnMaterialPropertiesEntity?
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
static public func parseClassName() -> String
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

### `getScnMaterial(block:)`

``` swift
public func getScnMaterial(block: @escaping (SCNMaterial?) -> Void)
```
