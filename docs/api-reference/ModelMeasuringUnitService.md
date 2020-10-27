# ModelMeasuringUnitService

``` swift
public class ModelMeasuringUnitService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](api-reference/DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainModelMeasuringUnitById(id:block:)`

``` swift
public func obtainModelMeasuringUnitById(id: String, block: @escaping (ModelMeasuringUnitEntity?, Error?) -> Void)
```
