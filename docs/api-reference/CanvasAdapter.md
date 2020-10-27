# CanvasAdapter

``` swift
public class CanvasAdapter
```

## Initializers

### `init()`

``` swift
public init()
```

## Properties

### `managementDelegate`

``` swift
var managementDelegate: CanvasManagementDelegate?
```

### `sceneView`

``` swift
var sceneView: SCNView?
```

### `isEmpty`

``` swift
var isEmpty: Bool
```

### `glowColor`

``` swift
var glowColor: CIColor = CIColor.blue
```

### `contentNode`

``` swift
let contentNode
```

### `modelHighlightingMode`

``` swift
var modelHighlightingMode: ModelHighlightingMode = .glow
```

### `cameraControlEnabled`

``` swift
var cameraControlEnabled = false
```

### `resetCameraPropertiesOnFocusToCenter`

``` swift
var resetCameraPropertiesOnFocusToCenter = false
```

### `modelSelectionEnabled`

``` swift
var modelSelectionEnabled = false
```

### `groundEnabled`

``` swift
var groundEnabled = false
```

### `groundColor`

``` swift
var groundColor: UIColor?
```

### `sceneEnvironment`

``` swift
var sceneEnvironment: SceneEnvironment = .basicLight
```

### `selectedModelNode`

``` swift
var selectedModelNode: ModelNode?
```

### `snappingsEnabled`

``` swift
var snappingsEnabled = true
```

### `overlappingOfModelsAllowed`

``` swift
var overlappingOfModelsAllowed = false
```

### `showSizes`

``` swift
var showSizes = false
```

### `gesturesEnabled`

``` swift
var gesturesEnabled = false
```

## Methods

### `refresh()`

``` swift
public func refresh()
```

### `handlePanGesture(recognizer:)`

``` swift
@objc public func handlePanGesture(recognizer: UIPanGestureRecognizer)
```

### `handlePinchGesture(recognizer:)`

``` swift
@objc public func handlePinchGesture(recognizer: UIPinchGestureRecognizer)
```

### `handleRotationGesture(recognizer:)`

``` swift
@objc public func handleRotationGesture(recognizer: UIRotationGestureRecognizer)
```

### `handleSingleTapGesture(recognizer:)`

``` swift
@objc public func handleSingleTapGesture(recognizer: UITapGestureRecognizer)
```

### `handleDoubleTapGesture(recognizer:)`

``` swift
@objc public func handleDoubleTapGesture(recognizer: UITapGestureRecognizer)
```

### `handleLongPressGesture(recognizer:)`

``` swift
@objc public func handleLongPressGesture(recognizer: UILongPressGestureRecognizer)
```

### `cameraRotate(xRadians:yRadians:)`

``` swift
public func cameraRotate(xRadians: Float, yRadians: Float)
```

### `focusToCenter(animate:resetCameraZoom:resetCameraOrientation:)`

``` swift
public func focusToCenter(animate: Bool = true, resetCameraZoom: Bool = false, resetCameraOrientation: Bool = false)
```

### `assignSceneLightingEnvironment(from:block:)`

``` swift
public func assignSceneLightingEnvironment(from sceneEntity: SceneEntity?, block: @escaping (Error?) -> Void)
```

### `resetSelection()`

``` swift
public func resetSelection()
```

### `selectModelById(id:)`

``` swift
public func selectModelById(id: String)
```

### `addModel(modelNode:position:rotation:selectModel:closeToPosition:notifyManagementDelegate:)`

``` swift
public func addModel(modelNode: ModelNode, position: SCNVector3? = nil, rotation: SCNVector4? = nil, selectModel: Bool = false, closeToPosition: SCNVector3? = nil, notifyManagementDelegate: Bool = true)
```

### `removeModelBy(id:)`

``` swift
public func removeModelBy(id: String)
```

### `removeModels()`

``` swift
public func removeModels()
```

### `assignMaterialToModel(modelId:nodeNamesOrNodeIds:materialId:material:)`

``` swift
public func assignMaterialToModel(modelId: String, nodeNamesOrNodeIds: [NodeNameOrNodeId], materialId: String?, material: SCNMaterial?)
```

### `replacePreviouslyAssignedMaterial(materialId:material:)`

``` swift
public func replacePreviouslyAssignedMaterial(materialId: String, material: SCNMaterial?)
```
