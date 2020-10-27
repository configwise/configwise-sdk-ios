# SnappingNode

``` swift
public class SnappingNode: SCNNode
```

## Inheritance

`SCNNode`

## Initializers

### `init()`

``` swift
public override init()
```

### `init?(coder:)`

``` swift
public required init?(coder aDecoder: NSCoder)
```

## Properties

### `snappingModel`

``` swift
var snappingModel: ModelNode?
```

### `connectToModel`

``` swift
var connectToModel: ModelNode?
```

## Methods

### `refresh()`

``` swift
public func refresh()
```

### `isSnappingModelInside()`

``` swift
public func isSnappingModelInside() -> Bool
```

### `isOverlappedWithModels(_:)`

``` swift
public func isOverlappedWithModels(_ models: [ModelNode]) -> Bool
```
