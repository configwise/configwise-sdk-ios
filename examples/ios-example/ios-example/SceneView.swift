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
    
    @Binding var canvasAdapter: CanvasAdapter?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> SCNView {
        let sceneView = SCNView()
        
        let canvasAdapter = CanvasAdapter()
        canvasAdapter.sceneView = sceneView
        canvasAdapter.gesturesEnabled = true
        canvasAdapter.cameraControlEnabled = true
        canvasAdapter.modelSelectionEnabled = false
        canvasAdapter.anchorObjectModelSelectionEnabled = false
        canvasAdapter.groundEnabled = false
        canvasAdapter.overlappingOfModelsAllowed = false
        canvasAdapter.resetCameraPropertiesOnFocusToCenter = true
        
        DispatchQueue.main.async {
            self.canvasAdapter = canvasAdapter
        }
        
        return sceneView
    }
    
    func updateUIView(_ view: SCNView, context: UIViewRepresentableContext<Self>) {
    }
}
