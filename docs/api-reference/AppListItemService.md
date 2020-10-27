# AppListItemService

``` swift
public class AppListItemService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainProductsOnlyByCurrentCatalog(offset:max:block:)`

``` swift
public func obtainProductsOnlyByCurrentCatalog(offset: Int? = nil, max: Int? = nil, block: @escaping ([AppListItemEntity], Error?) -> Void)
```

### `obtainAppListItemsByCurrentCatalog(parent:offset:max:block:)`

``` swift
public func obtainAppListItemsByCurrentCatalog(parent: AppListItemEntity? = nil, offset: Int? = nil, max: Int? = nil, block: @escaping ([AppListItemEntity], Error?) -> Void)
```

### `obtainAppListItemById(id:block:)`

``` swift
public func obtainAppListItemById(id: String, block: @escaping (AppListItemEntity?, Error?) -> Void)
```
