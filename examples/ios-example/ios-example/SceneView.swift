//
//  SceneView.swift
//  ios-example
//
//  Created by Sergey Muravev on 03.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import SceneKit
import ConfigWiseSDK

struct SceneView: UIViewRepresentable {

    var configuration = { (scnView: SCNView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> SCNView {
        SCNView()
    }
    
    func updateUIView(_ scnView: SCNView, context: UIViewRepresentableContext<Self>) {
        self.configuration(scnView)
    }
}

// With this little helpful extension, you can access the configuration through a modifier like other SwiftUI views
extension View where Self == SceneView {
    func configure(_ configuration: @escaping (SCNView) -> Void) -> Self {
        Self.init(configuration: configuration)
    }
}
