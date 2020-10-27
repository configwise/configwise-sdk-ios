# ArManagementDelegate

``` swift
public protocol ArManagementDelegate: AdapterManagementDelegate
```

## Inheritance

[`AdapterManagementDelegate`](/AdapterManagementDelegate)

## Requirements

### onArShowHelpMessage(type:​message:​)

``` swift
func onArShowHelpMessage(type: ArHelpMessageType?, message: String)
```

### onArHideHelpMessage()

``` swift
func onArHideHelpMessage()
```

### onArSessionError(error:​message:​)

``` swift
func onArSessionError(error: Error, message: String)
```

### onArSessionInterrupted(message:​)

``` swift
func onArSessionInterrupted(message: String)
```

### onArSessionInterruptionEnded(message:​)

``` swift
func onArSessionInterruptionEnded(message: String)
```

### onArSessionStarted(restarted:​)

``` swift
func onArSessionStarted(restarted: Bool)
```

### onArSessionPaused()

``` swift
func onArSessionPaused()
```

### onArUnsupported(message:​)

``` swift
func onArUnsupported(message: String)
```

### onArPlaneDetected(simdWorldPosition:​)

``` swift
func onArPlaneDetected(simdWorldPosition: float3)
```

### onArModelAdded(modelId:​componentId:​error:​)

``` swift
func onArModelAdded(modelId: String, componentId: String, error: Error?)
```
