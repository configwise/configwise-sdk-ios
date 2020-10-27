# AuthService

``` swift
public class AuthService: DaoAwareService
```

## Inheritance

[`DaoAwareService`](DaoAwareService)

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `signIn(appName:appVersion:email:password:block:)`

``` swift
public func signIn(appName: String? = nil, appVersion: String? = nil, email: String? = nil, password: String? = nil, block: @escaping (UserEntity?, Error?) -> Void)
```

### `signOut(notify:)`

``` swift
public func signOut(notify: Bool = true)
```

### `currentUser(block:)`

``` swift
public func currentUser(block: @escaping (UserEntity?) -> Void)
```

### `currentCompany(block:)`

``` swift
public func currentCompany(block: @escaping (CompanyEntity?, Error?) -> Void)
```

### `isCurrentUserCompanyManager(block:)`

``` swift
public func isCurrentUserCompanyManager(block: @escaping (Bool) -> Void)
```

### `isCurrentUserCompanyEmployee(block:)`

``` swift
public func isCurrentUserCompanyEmployee(block: @escaping (Bool) -> Void)
```

### `isCurrentUserCompanyAuthToken(block:)`

``` swift
public func isCurrentUserCompanyAuthToken(block: @escaping (Bool) -> Void)
```

### `signUpAsDemoCompanyEmployee(email:password:fullName:block:)`

``` swift
public func signUpAsDemoCompanyEmployee(email: String, password: String, fullName: String, block: @escaping (String?, Error?) -> Void)
```

### `resetPassword(email:block:)`

``` swift
public func resetPassword(email: String, block: @escaping (Error?) -> Void)
```
