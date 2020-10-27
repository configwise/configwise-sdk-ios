# ComponentEntity

``` swift
public class ComponentEntity: CatalogAwareEntity, PFSubclassing
```

## Inheritance

[`CatalogAwareEntity`](/CatalogAwareEntity), `PFSubclassing`

## Properties

### `parent`

``` swift
var parent: ComponentEntity?
```

### `name`

``` swift
var name: String
```

### `appName`

``` swift
var appName: String
```

### `genericName`

``` swift
var genericName: String
```

### `productNumber`

``` swift
var productNumber: String
```

### `price`

``` swift
var price: Double
```

### `desc`

``` swift
var desc: String
```

### `isFloating`

``` swift
var isFloating: Bool
```

### `isNonFloating`

``` swift
var isNonFloating: Bool
```

### `thumbnailFileUrl`

``` swift
var thumbnailFileUrl: URL?
```

### `genericModelFileUrl`

``` swift
var genericModelFileUrl: URL?
```

### `isGenericModelFileExists`

``` swift
var isGenericModelFileExists: Bool
```

### `snappingAreas`

``` swift
var snappingAreas: [SnappingAreaEntity]
```

### `nodesToTags`

``` swift
var nodesToTags: [NodeToTagEntity]
```

### `tagsToMaterials`

``` swift
var tagsToMaterials: [TagToMaterialsEntity]
```

### `combinations`

``` swift
var combinations: [CombinationEntity]
```

### `variancesRelation`

``` swift
var variancesRelation: PFRelation<ComponentEntity>?
```

### `productLink`

``` swift
var productLink: String
```

### `productLinkUrl`

``` swift
var productLinkUrl: URL?
```

### `fileSizes`

``` swift
var fileSizes: [FileSizeEntity]
```

### `totalSize`

``` swift
var totalSize: Int
```

### `isVisible`

``` swift
var isVisible: Bool
```

### `images`

``` swift
var images: ImagesEntity
```

### `pricePrefix`

``` swift
var pricePrefix: String?
```

## Methods

### `isThumbnailFileExist()`

``` swift
public func isThumbnailFileExist() -> Bool
```

### `getThumbnailFileData(block:)`

``` swift
public func getThumbnailFileData(block: @escaping (Data?, Error?) -> Void)
```

### `isSnappingAreasExist()`

``` swift
public func isSnappingAreasExist() -> Bool
```

### `isNodesToTagsExist()`

``` swift
public func isNodesToTagsExist() -> Bool
```

### `getNodeNamesOrNodeIdsByTag(_:)`

``` swift
public func getNodeNamesOrNodeIdsByTag(_ tag: String) -> [NodeNameOrNodeId]
```

### `getMaterialIdsByTag(_:)`

``` swift
public func getMaterialIdsByTag(_ tag: String) -> [String]
```

### `isTagsToMaterialsExist()`

``` swift
public func isTagsToMaterialsExist() -> Bool
```

### `getTagsToMaterialsByMaterialId(_:)`

``` swift
public func getTagsToMaterialsByMaterialId(_ materialId: String) -> [TagToMaterialsEntity]
```

### `isMaterialAssigned(materialId:)`

``` swift
public func isMaterialAssigned(materialId: String) -> Bool
```

### `isCombinationsExist()`

``` swift
public func isCombinationsExist() -> Bool
```

### `parseClassName()`

``` swift
public static func parseClassName() -> String
```
