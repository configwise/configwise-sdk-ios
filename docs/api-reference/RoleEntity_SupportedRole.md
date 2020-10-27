# RoleEntity.SupportedRole

``` swift
public enum SupportedRole
```

## Inheritance

`String`

## Enumeration Cases

### `roleSystemAdmin`

``` swift
case roleSystemAdmin
```

  - Those users are used by VipaHelda. This role represents most priveleged users (system admins).

### `roleSystemSales`

``` swift
case roleSystemSales
```

  - VipaHelda users who manage sales of product.

### `roleSystemFinance`

``` swift
case roleSystemFinance
```

  - VipaHelda users who manages finance / payments.

### `roleCompanyManager`

``` swift
case roleCompanyManager
```

  - This kind of users are Company's users.

  - Company Manager is most priveleged user who can create (manage) internal Company Employees.

  - Company Managers uses 3DE app to create / edit Company Catalogs.

### `roleCompanyEmployee`

``` swift
case roleCompanyEmployee
```

  - Company Employee who visits clients of company and make orders (based on clients wishes).

  - Company Employee uses IPD app to construct scene and then make (publish) an Order.

### `roleCompanyAuthToken`

``` swift
case roleCompanyAuthToken
```

  - Company Auth Token role - used in B2C mode. Each Company may have own auth token to pass athorization in SDK.

  - This kind of authorization doesn't require company users authorizatin then.

  - Permissions for such kind of authorized session are the same like for ROLE\_COMPANY\_EMPLOYEE.
