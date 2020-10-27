# ArAdapter

``` swift
public class ArAdapter: NSObject
```

## Inheritance

`ARSCNViewDelegate`, `NSObject`

## Properties

### `managementDelegate`

``` swift
var managementDelegate: ArManagementDelegate?
```

### `sceneView`

``` swift
var sceneView: ARSCNView?
```

### `isEmpty`

``` swift
var isEmpty: Bool
```

### `modelHighlightingMode`

``` swift
var modelHighlightingMode: ModelHighlightingMode = .glow
```

### `glowColor`

``` swift
var glowColor: CIColor = CIColor.blue
```

### `modelNodes`

``` swift
var modelNodes: [ModelNode] = []
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

### `movementEnabled`

``` swift
var movementEnabled = false
```

### `rotationEnabled`

``` swift
var rotationEnabled = false
```

### `scalingEnabled`

``` swift
var scalingEnabled = false
```

## Methods

### `assignSceneLightingEnvironment(from:block:)`

``` swift
public func assignSceneLightingEnvironment(from sceneEntity: SceneEntity?, block: @escaping (Error?) -> Void)
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

### `renderer(_:updateAtTime:)`

``` swift
public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
```

### `renderer(_:didAdd:for:)`

``` swift
public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
```

### `renderer(_:didUpdate:for:)`

``` swift
public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
```

### `renderer(_:didRemove:for:)`

``` swift
public func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor)
```

### `session(_:didFailWithError:)`

``` swift
public func session(_ session: ARSession, didFailWithError error: Error)
```

### `sessionWasInterrupted(_:)`

``` swift
public func sessionWasInterrupted(_ session: ARSession)
```

### `sessionInterruptionEnded(_:)`

``` swift
public func sessionInterruptionEnded(_ session: ARSession)
```

### `sessionShouldAttemptRelocalization(_:)`

``` swift
public func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool
```

### `runArSession(restartArExperience:)`

``` swift
public func runArSession(restartArExperience: Bool = false)
```

### `pauseArSession()`

``` swift
public func pauseArSession()
```

### `resetSelection()`

``` swift
public func resetSelection()
```

### `selectModelById(id:)`

``` swift
public func selectModelById(id: String)
```

### `addModel(modelNode:simdWorldPosition:selectModel:)`

``` swift
public func addModel(modelNode: ModelNode, simdWorldPosition: float3? = nil, selectModel: Bool = false)
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
