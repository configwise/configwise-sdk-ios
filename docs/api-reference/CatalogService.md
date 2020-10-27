# CatalogService

``` swift
public class CatalogService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainCatalogByCurrentCompany(block:)`

``` swift
public func obtainCatalogByCurrentCompany(block: @escaping (CatalogEntity?, Error?) -> Void)
```

### `obtainCatalogByCompany(company:block:)`

``` swift
public func obtainCatalogByCompany(company: CompanyEntity, block: @escaping (CatalogEntity?, Error?) -> Void)
```
