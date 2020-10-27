# ConceptEntity

``` swift
@objc(ConceptEntity) public class ConceptEntity: NSManagedObject
```

## Inheritance

`NSManagedObject`

## Properties

### `conflictsMessage`

``` swift
var conflictsMessage: String?
```

### `name`

``` swift
var name: String
```

### `popularity`

``` swift
var popularity: Int16
```

### `thumbnail`

``` swift
var thumbnail: NSData?
```

### `user_id`

``` swift
var user_id: String
```

### `groundEnabled`

``` swift
var groundEnabled: Bool
```

### `groundColorRgba`

``` swift
var groundColorRgba: String?
```

### `conceptItems`

``` swift
var conceptItems: NSSet?
```

### `lastOpened`

``` swift
var lastOpened: Date
```

### `groundColor`

``` swift
var groundColor: UIColor?
```

## Methods

### `fetchRequest()`

``` swift
@nonobjc public class func fetchRequest() -> NSFetchRequest<ConceptEntity>
```

### `addToConceptItems(_:)`

``` swift
@objc(addConceptItemsObject) @NSManaged public func addToConceptItems(_ value: ConceptItemEntity)
```

### `removeFromConceptItems(_:)`

``` swift
@objc(removeConceptItemsObject) @NSManaged public func removeFromConceptItems(_ value: ConceptItemEntity)
```

### `addToConceptItems(_:)`

``` swift
@objc(addConceptItems) @NSManaged public func addToConceptItems(_ values: NSSet)
```

### `removeFromConceptItems(_:)`

``` swift
@objc(removeConceptItems) @NSManaged public func removeFromConceptItems(_ values: NSSet)
```

### `isComponentExists(_:)`

``` swift
public func isComponentExists(_ component: ComponentEntity) -> Bool
```

### `obtainComponents(block:)`

``` swift
public func obtainComponents(block: @escaping ([ComponentEntity], Error?) -> Void)
```

### `isMaterialAssigned(materialId:)`

``` swift
public func isMaterialAssigned(materialId: String) -> Bool
```
