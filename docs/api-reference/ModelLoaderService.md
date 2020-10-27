# ModelLoaderService

``` swift
public class ModelLoaderService: NSObject, CAAnimationDelegate, SCNSceneExportDelegate
```

## Inheritance

`CAAnimationDelegate`, `NSObject`, `SCNSceneExportDelegate`

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `loadModelsBy(components:block:progressBlock:)`

``` swift
public func loadModelsBy(components: [ComponentEntity], block: @escaping ([String: (model: ModelNode?, error: Error?)]) -> Void, progressBlock: ProgressBlock? = nil)
```

### `loadModelBy(component:withModelId:block:progressBlock:)`

``` swift
public func loadModelBy(component: ComponentEntity, withModelId: String? = nil, block: @escaping (ModelNode?, Error?) -> Void, progressBlock: ProgressBlock? = nil)
```
