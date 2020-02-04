# ConfigWise SDK (iOS)

TODO: Put ConfigWiseSDK documentation, here (explain how to use it, description of examples code, etc).

## Build example project

+ Clone (or download) the current repository.

+ `$ cd examples; pod install`

+ Open `examples/examples.xcworkspace` in your Xcode.

+ Set your COMPANY_AUTH_TOKEN in the `ios-example/AppEnvironment.swift` file (see this token in the CBO).   

        var mode: SdkVariant {
            .B2C
        }
        
        init() {
            // Let's initialize ConfigWiseSDK here
            ConfigWiseSDK.initialize([
                .variant: self.mode,
                .companyAuthToken: "YOUR_COMPANY_AUTH_TOKEN",
                .debugLogging: true,
                .debug3d: false
            ])
            . . .
        }

+ Build and run `ios-example` scheme.

+ Change `SdkVariant` to `.B2B` mode in the `ios-example/AppEnvironment.swift` file.

        var mode: SdkVariant {
            .B2B
        }

+ Build and run `ios-example` scheme.
