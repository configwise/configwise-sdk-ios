# AdapterManagementDelegate

``` swift
public protocol AdapterManagementDelegate
```

## Requirements

### onModelPositionChanged(modelId:​componentId:​position:​rotation:​)

``` swift
func onModelPositionChanged(modelId: String, componentId: String, position: SCNVector3, rotation: SCNVector4)
```

### onModelSelected(modelId:​componentId:​)

``` swift
func onModelSelected(modelId: String, componentId: String)
```

### onModelDeleted(modelId:​componentId:​)

``` swift
func onModelDeleted(modelId: String, componentId: String)
```

### onSelectionReset()

``` swift
func onSelectionReset()
```
