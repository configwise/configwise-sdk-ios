# SceneService

``` swift
public class SceneService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainSceneById(id:block:)`

``` swift
public func obtainSceneById(id: String, block: @escaping (SceneEntity?, Error?) -> Void)
```

### `obtainSceneByCurrentCatalog(block:)`

``` swift
public func obtainSceneByCurrentCatalog(block: @escaping (SceneEntity?, Error?) -> Void)
```

### `obtainSceneByCatalog(catalog:block:)`

``` swift
public func obtainSceneByCatalog(catalog: CatalogEntity, block: @escaping (SceneEntity?, Error?) -> Void)
```

### `obtainAllScenesByCatalog(catalog:offset:max:block:)`

``` swift
public func obtainAllScenesByCatalog(catalog: CatalogEntity, offset: Int? = nil, max: Int? = nil, block: @escaping ([SceneEntity], Error?) -> Void)
```
