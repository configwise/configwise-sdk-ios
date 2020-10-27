# ConceptItemEntity

``` swift
@objc(ConceptItemEntity) public class ConceptItemEntity: NSManagedObject
```

## Inheritance

`NSManagedObject`

## Properties

### `id`

``` swift
var id: String
```

### `component_id`

``` swift
var component_id: String
```

### `positionX`

``` swift
var positionX: Float
```

### `positionY`

``` swift
var positionY: Float
```

### `positionZ`

``` swift
var positionZ: Float
```

### `rotationW`

``` swift
var rotationW: Float
```

### `rotationX`

``` swift
var rotationX: Float
```

### `rotationY`

``` swift
var rotationY: Float
```

### `rotationZ`

``` swift
var rotationZ: Float
```

### `assignedMaterials`

``` swift
var assignedMaterials: NSSet?
```

### `concept`

``` swift
var concept: ConceptEntity?
```

## Methods

### `fetchRequest()`

``` swift
@nonobjc public class func fetchRequest() -> NSFetchRequest<ConceptItemEntity>
```

### `addToAssignedMaterials(_:)`

``` swift
@objc(addAssignedMaterialsObject) @NSManaged public func addToAssignedMaterials(_ value: AssignedMaterialEntity)
```

### `removeFromAssignedMaterials(_:)`

``` swift
@objc(removeAssignedMaterialsObject) @NSManaged public func removeFromAssignedMaterials(_ value: AssignedMaterialEntity)
```

### `addToAssignedMaterials(_:)`

``` swift
@objc(addAssignedMaterials) @NSManaged public func addToAssignedMaterials(_ values: NSSet)
```

### `removeFromAssignedMaterials(_:)`

``` swift
@objc(removeAssignedMaterials) @NSManaged public func removeFromAssignedMaterials(_ values: NSSet)
```

### `obtainComponent(block:)`

``` swift
public func obtainComponent(block: @escaping (ComponentEntity?, Error?) -> Void)
```

### `assignMaterial(tag:materialId:)`

``` swift
public func assignMaterial(tag: String, materialId: String?)
```

### `getAssignedMaterials(block:)`

``` swift
public func getAssignedMaterials(block: @escaping ([(tag: String, materialId: String?, scnMaterial: SCNMaterial?)], Error?) -> Void)
```

### `isMaterialAssigned(materialId:)`

``` swift
public func isMaterialAssigned(materialId: String) -> Bool
```
