# CompanyEntity

``` swift
public class CompanyEntity: PFObject, PFSubclassing
```

## Inheritance

`PFObject`, `PFSubclassing`

## Properties

### `name`

``` swift
var name: String
```

### `logoFileUrl`

``` swift
var logoFileUrl: URL?
```

### `watermarkFileUrl`

``` swift
var watermarkFileUrl: URL?
```

### `watermarkPosition`

``` swift
var watermarkPosition: WatermarkPosition
```

### `watermarkWidthFactor`

``` swift
var watermarkWidthFactor: Float
```

### `watermarkAlpha`

``` swift
var watermarkAlpha: Float
```

### `watermarkPoweredbyPosition`

``` swift
var watermarkPoweredbyPosition: WatermarkPosition
```

### `watermarkPoweredbyWidthFactor`

``` swift
var watermarkPoweredbyWidthFactor: Float
```

### `watermarkPoweredbyAlpha`

``` swift
var watermarkPoweredbyAlpha: Float
```

### `conceptAbility`

``` swift
var conceptAbility: Bool
```

### `orderAbility`

``` swift
var orderAbility: Bool
```

### `extraProductUrlParams`

``` swift
var extraProductUrlParams: String
```

### `liveChatAbility`

``` swift
var liveChatAbility: Bool
```

## Methods

### `getLogoFileData(block:)`

``` swift
public func getLogoFileData(block: @escaping (Data?, Error?) -> Void)
```

### `getWatermarkFileData(block:)`

``` swift
public func getWatermarkFileData(block: @escaping (Data?, Error?) -> Void)
```

### `parseClassName()`

``` swift
public static func parseClassName() -> String
```
