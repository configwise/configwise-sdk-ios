# ComponentService

``` swift
public class ComponentService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](configwise-sdk-ios/api-reference/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainComponentById(id:block:)`

``` swift
public func obtainComponentById(id: String, block: @escaping (ComponentEntity?, Error?) -> Void)
```

### `obtainAllComponentsByIds(ids:offset:max:block:)`

``` swift
public func obtainAllComponentsByIds(ids: [String], offset: Int? = nil, max: Int? = nil, block: @escaping ([ComponentEntity], Error?) -> Void)
```

### `obtainAllComponentsByCurrentCatalog(offset:max:block:)`

``` swift
public func obtainAllComponentsByCurrentCatalog(offset: Int? = nil, max: Int? = nil, block: @escaping ([ComponentEntity], Error?) -> Void)
```

### `obtainAllComponentsByCatalog(catalog:offset:max:block:)`

``` swift
public func obtainAllComponentsByCatalog(catalog: CatalogEntity, offset: Int? = nil, max: Int? = nil, block: @escaping ([ComponentEntity], Error?) -> Void)
```

### `obtainComponentByCurrentCatalogAndProductNr(productNr:block:)`

``` swift
public func obtainComponentByCurrentCatalogAndProductNr(productNr: String, block: @escaping (ComponentEntity?, Error?) -> Void)
```

### `obtainComponentByCatalogAndProductNr(catalog:productNr:block:)`

``` swift
public func obtainComponentByCatalogAndProductNr(catalog: CatalogEntity, productNr: String, block: @escaping (ComponentEntity?, Error?) -> Void)
```

### `obtainProductUrlByComponentOfCurrentCompany(component:block:)`

``` swift
public func obtainProductUrlByComponentOfCurrentCompany(component: ComponentEntity, block: @escaping (URL?, Error?) -> Void)
```

### `obtainAllVariancesByComponent(component:offset:max:block:)`

``` swift
public func obtainAllVariancesByComponent(component: ComponentEntity, offset: Int? = nil, max: Int? = nil, block: @escaping ([ComponentEntity], Error?) -> Void)
```

### `countVariancesByComponent(component:block:)`

``` swift
public func countVariancesByComponent(component: ComponentEntity, block: @escaping (Int, Error?) -> Void)
```

### `getComponentThumbnailHome(component:block:)`

``` swift
public func getComponentThumbnailHome(component: ComponentEntity, block: @escaping (String?, Error?) -> Void)
```
