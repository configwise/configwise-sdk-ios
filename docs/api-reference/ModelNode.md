# ModelNode

``` swift
public class ModelNode: SCNNode, Identifiable
```

## Inheritance

`Identifiable`, `SCNNode`

## Initializers

### `init()`

``` swift
public override init()
```

### `init?(coder:)`

``` swift
required public init?(coder aDecoder: NSCoder)
```

### `init(id:componentId:)`

``` swift
public init(id: String, componentId: String)
```

## Properties

### `id`

``` swift
let id: String
```

### `componentId`

``` swift
let componentId: String
```

### `isHighlighted`

``` swift
var isHighlighted: Bool
```

### `isFloating`

``` swift
var isFloating = false
```

### `offsetCenterPosition`

``` swift
var offsetCenterPosition: SCNVector3?
```

### `contentNode`

``` swift
let contentNode
```

### `isSizesShown`

``` swift
var isSizesShown: Bool
```

## Methods

### `add(childNodes:)`

``` swift
public func add(childNodes: [SCNNode])
```

### `highlight(mode:)`

``` swift
public func highlight(mode: ModelHighlightingMode)
```

### `unhighlight()`

``` swift
public func unhighlight()
```

### `assignMaterial(material:nodeNamesOrNodeIds:)`

``` swift
public func assignMaterial(material: SCNMaterial?, nodeNamesOrNodeIds: [NodeNameOrNodeId])
```

### `assignMaterial(material:node:)`

``` swift
public func assignMaterial(material: SCNMaterial?, node: SCNNode)
```

### `showSizes(lineColor:textColor:)`

``` swift
public func showSizes(lineColor: UIColor = UIColor.white, textColor: UIColor = UIColor.black)
```

### `hideSizes()`

``` swift
public func hideSizes()
```
