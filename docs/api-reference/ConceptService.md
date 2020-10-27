# ConceptService

``` swift
public class ConceptService
```

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `spawnConcept(userId:name:)`

``` swift
public func spawnConcept(userId: String, name: String) -> ConceptEntity
```

### `spawnConceptItem(componentId:position:rotation:)`

``` swift
public func spawnConceptItem(componentId: String, position: SCNVector3, rotation: SCNVector4) -> ConceptItemEntity
```

### `spawnAssignedMaterial(tag:materialId:)`

``` swift
public func spawnAssignedMaterial(tag: String, materialId: String?) -> AssignedMaterialEntity
```

### `clone(concept:)`

``` swift
public func clone(concept: ConceptEntity) -> ConceptEntity
```

### `clone(conceptItem:)`

``` swift
public func clone(conceptItem: ConceptItemEntity) -> ConceptItemEntity
```

### `clone(assignedMaterial:)`

``` swift
public func clone(assignedMaterial: AssignedMaterialEntity) -> AssignedMaterialEntity
```

### `delete(concept:)`

``` swift
public func delete(concept: ConceptEntity)
```

### `delete(conceptItem:)`

``` swift
public func delete(conceptItem: ConceptItemEntity)
```

### `delete(assignedMaterial:)`

``` swift
public func delete(assignedMaterial: AssignedMaterialEntity)
```

### `getAllConceptsByUserId(userId:block:)`

``` swift
public func getAllConceptsByUserId(userId: String, block: @escaping ([ConceptEntity], Error?) -> Void)
```
