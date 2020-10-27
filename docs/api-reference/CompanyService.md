# CompanyService

``` swift
public class CompanyService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](configwise-sdk-ios/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainCompanyById(id:block:)`

``` swift
public func obtainCompanyById(id: String, block: @escaping (CompanyEntity?, Error?) -> Void)
```

### `obtainCompanyByName(name:block:)`

``` swift
public func obtainCompanyByName(name: String, block: @escaping (CompanyEntity?, Error?) -> Void)
```
