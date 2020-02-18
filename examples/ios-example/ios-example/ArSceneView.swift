//
//  ArSceneView.swift
//  ios-example
//
//  Created by Sergey Muravev on 16.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import ARKit
import ConfigWiseSDK

struct ArSceneView: UIViewRepresentable {

    var onInitView = { (view: ARSCNView) in }
    
    var onUpdateView = { (view: ARSCNView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> ARSCNView {
        let view = ARSCNView()
        self.onInitView(view)
        return view
    }
    
    func updateUIView(_ view: ARSCNView, context: UIViewRepresentableContext<Self>) {
        self.onUpdateView(view)
    }
}
