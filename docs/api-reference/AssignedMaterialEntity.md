# AssignedMaterialEntity

``` swift
@objc(AssignedMaterialEntity) public class AssignedMaterialEntity: NSManagedObject
```

## Inheritance

`NSManagedObject`

## Properties

### `material_id`

``` swift
var material_id: String?
```

### `tag`

``` swift
var tag: String
```

### `conceptItem`

``` swift
var conceptItem: ConceptItemEntity?
```

## Methods

### `fetchRequest()`

``` swift
@nonobjc public class func fetchRequest() -> NSFetchRequest<AssignedMaterialEntity>
```
