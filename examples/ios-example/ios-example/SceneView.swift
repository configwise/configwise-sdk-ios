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

    var onInitView = { (view: SCNView) in }
    
    var onUpdateView = { (view: SCNView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> SCNView {
        let view = SCNView()
        self.onInitView(view)
        return view
    }
    
    func updateUIView(_ view: SCNView, context: UIViewRepresentableContext<Self>) {
        self.onUpdateView(view)
    }
}
