# MaterialService

``` swift
public class MaterialService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](configwise-sdk-ios/api-reference/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainMaterialById(id:block:)`

``` swift
public func obtainMaterialById(id: String, block: @escaping (MaterialEntity?, Error?) -> Void)
```

### `obtainAllMaterialsByIds(ids:offset:max:block:)`

``` swift
public func obtainAllMaterialsByIds(ids: [String], offset: Int? = nil, max: Int? = nil, block: @escaping ([MaterialEntity], Error?) -> Void)
```

### `obtainAllMaterialsByCatalog(catalog:offset:max:block:)`

``` swift
public func obtainAllMaterialsByCatalog(catalog: CatalogEntity, offset: Int? = nil, max: Int? = nil, block: @escaping ([MaterialEntity], Error?) -> Void)
```

### `obtainFirstMaterialsOfComponent(_:block:)`

``` swift
public func obtainFirstMaterialsOfComponent(_ component: ComponentEntity, block: @escaping ([(material: SCNMaterial, nodeNamesOrNodeIds: [NodeNameOrNodeId])], Error?) -> Void)
```
