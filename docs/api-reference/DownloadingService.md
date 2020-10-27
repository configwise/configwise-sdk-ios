# DownloadingService

``` swift
public class DownloadingService
```

## Properties

### `sharedInstance`

``` swift
let sharedInstance
```

## Methods

### `obtainFromLocalCache(url:downloadIfRequired:block:progressBlock:)`

``` swift
public func obtainFromLocalCache(url: URL, downloadIfRequired: Bool = true, block: @escaping (Data?, Error?) -> Void, progressBlock: ProgressBlock? = nil)
```

### `obtainFromLocalCache(urls:block:progressBlock:)`

``` swift
public func obtainFromLocalCache(urls: [URL], block: @escaping ([URL: (data: Data?, error: Error?)]) -> Void, progressBlock: ProgressBlock? = nil)
```

### `addToLocalCache(url:block:progressBlock:)`

``` swift
public func addToLocalCache(url: URL, block: @escaping (Data?, Error?) -> Void, progressBlock: ProgressBlock? = nil)
```

### `addToLocalCache(urls:block:progressBlock:)`

``` swift
public func addToLocalCache(urls: [URL], block: @escaping ([URL: (data: Data?, error: Error?)]) -> Void, progressBlock: ProgressBlock? = nil)
```

### `removeFromLocalCache(url:)`

``` swift
public func removeFromLocalCache(url: URL)
```

### `removeFromLocalCache(urls:)`

``` swift
public func removeFromLocalCache(urls: [URL])
```

### `getLocallyCachedFileUrl(of:)`

``` swift
public func getLocallyCachedFileUrl(of url: URL) -> URL
```

### `isExistsInLocalCache(url:)`

``` swift
public func isExistsInLocalCache(url: URL) -> Bool
```

### `writeToLocalCache(filePath:data:)`

``` swift
public func writeToLocalCache(filePath: String, data: Data) throws -> URL
```

### `removeFromLocalCache(filePath:)`

``` swift
public func removeFromLocalCache(filePath: String)
```

### `upload(_:as:block:)`

``` swift
public func upload(_ fileUrl: URL, as fileKey: String, block: @escaping (Error?) -> Void)
```

### `isFileExistsOnServer(fileKey:block:)`

``` swift
public func isFileExistsOnServer(fileKey: String, block: @escaping (Bool, Error?) -> Void)
```

### `deleteFileFromServer(fileKey:block:)`

``` swift
public func deleteFileFromServer(fileKey: String, block: @escaping (Error?) -> Void)
```
