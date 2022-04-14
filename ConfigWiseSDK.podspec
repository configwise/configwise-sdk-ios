Pod::Spec.new do |s|
    s.name                    = "ConfigWiseSDK"
    s.version                 = "1.7.0"
    s.summary                 = "#{s.name} (iOS) #{s.version}"
    s.homepage                = "https://github.com/configwise/configwise-sdk-ios"

    s.author                  = { "VipaHelda BV" => "sdk@configwise.io" }
    s.license                 = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.source                  = { :git => "https://github.com/configwise/configwise-sdk-ios.git", :tag => "#{s.version}" }
    s.vendored_frameworks     = "#{s.name}/Sources/#{s.name}.xcframework"

    s.platform                = :ios
    s.ios.deployment_target   = '14.5'

    s.frameworks = 'ARKit', 'SceneKit', 'CoreData'
    s.dependency 'Parse', '~> 1.19.0'
    s.dependency 'ParseLiveQuery', '~> 2.8.0'
    s.dependency 'Alamofire', '~> 5.4.0'
    s.dependency 'CocoaLumberjack/Swift', '~> 3.7.0'
    s.dependency 'ZIPFoundation', '~> 0.9.0'
end
