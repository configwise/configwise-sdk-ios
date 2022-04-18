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
    
    @Binding var arAdapter: ArAdapter?
    
    var onArSessionStarted: () -> Void
    
    var onHudEnabled: (Bool) -> Void
    
    var onPlaneOn: (ARPlaneAnchor.Alignment, simd_float4x4) -> Void
    
    var onPlaneOff: (simd_float4x4) -> Void
    
    var onModelAdded: (ComponentModelNode) -> Void

    var onModelDeleted: (ComponentModelNode) -> Void
    
    var onModelTransformChanged: (ComponentModelNode) -> Void
    
    var onModelSelected: (ComponentModelNode) -> Void
    
    var onSelectionReset: () -> Void
    
    var onAdapterMessage: (CWSDK.LogLevel, String) -> Void
    
    func makeCoordinator() -> ArSceneView.Coordinator {
        return Coordinator(representable: self)
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        
        let arAdapter = ArAdapter(sceneView: sceneView)
        
        arAdapter.managementDelegate = context.coordinator // initialize delegate (ArManagementDelegate
                                                           // protocol) to handle callbacks from ArAdapter
        
        arAdapter.modelSelectionEnabled = true
        
        arAdapter.modelMovementEnabled = true              // enable or disable movements of models in the scene
                                                           // (one and two fingers pan gesture is used to move 3D objects)
        
        arAdapter.modelRotationEnabled = true              // enable or disable rotation of 3D objects in the scene
                                                           // (rotate gesture is used for that)
        
        arAdapter.modelScalingEnabled = true               // enable or disable scaling of shown 3D objects
                                                           // (pinch gesture is used for that)
        
        arAdapter.snappingsEnabled = true                  // enable or disable snappings features in the scene
                                                           // double tap (on shown snapping area) moves and connects
                                                           // selected model to snapping area.
        
        arAdapter.overlappingOfModelsAllowed = true        // enable or disable ability to move models to
                                                           // positions where other models already placed.
                                                           // if false then ArAdapter doesn't allow to put
                                                           // 3D objects in the overlapped positions.
        
        arAdapter.glowColor = .blue                        // color of highlighting glow effect
        
        arAdapter.hud.primaryColor = #colorLiteral(red: 0.1874456704, green: 0.2679388523, blue: 1, alpha: 1)
        arAdapter.hud.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        arAdapter.hudEnabled = true
        
        arAdapter.useInfinitPlaneDetection = true
        
        DispatchQueue.main.async {
            self.arAdapter = arAdapter
        }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }
    
    static func dismantleUIView(_ uiView: ARSCNView, coordinator: ArSceneView.Coordinator) {
    }
    
    final class Coordinator: ArManagementDelegate {
        
        private let representable: ArSceneView
        
        init(representable: ArSceneView) {
            self.representable = representable
        }
        
        func onArSessionStarted() {
            self.representable.onArSessionStarted()
        }
        
        func onHudEnabled(enabled: Bool) {
            self.representable.onHudEnabled(enabled)
        }
        
        func onPlaneOn(alignment: ARPlaneAnchor.Alignment, lastWorldTransform: simd_float4x4) {
            self.representable.onPlaneOn(alignment, lastWorldTransform)
        }
        
        func onPlaneOff(lastWorldTransform: simd_float4x4) {
            self.representable.onPlaneOff(lastWorldTransform)
        }
        
        func onModelAdded(model: ComponentModelNode) {
            self.representable.onModelAdded(model)
        }
        
        func onModelDeleted(model: ComponentModelNode) {
            self.representable.onModelDeleted(model)
        }
        
        func onModelTransformChanged(model: ComponentModelNode) {
            self.representable.onModelTransformChanged(model)
        }
        
        func onModelSelected(model: ComponentModelNode) {
            self.representable.onModelSelected(model)
        }
        
        func onSelectionReset() {
            self.representable.onSelectionReset()
        }
        
        func onAnchorObjectModelSelected(model: AnchorObjectModelNode) {
        }
        
        func onAnchorObjectModelDeselected(model: AnchorObjectModelNode) {
        }
        
        func onAdapterMessage(logLevel: CWSDK.LogLevel, message: String) {
            self.representable.onAdapterMessage(logLevel, message)
        }
    }
}
