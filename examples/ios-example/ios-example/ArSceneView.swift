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
    
    var onInitView = { (view: ARSCNView, arAdapter: ArAdapter) in }
    
    var onArShowHelpMessage: (ArHelpMessageType?, String) -> Void
    
    var onArHideHelpMessage: () -> Void
    
    var onAdapterError: (Error) -> Void
    
    var onAdapterErrorCritical: (Error) -> Void
    
    var onArSessionStarted: (Bool) -> Void
    
    var onArSessionPaused: () -> Void
    
    var onArUnsupported: (String) -> Void
    
    var onArFirstPlaneDetected: (simd_float3) -> Void
    
    var onModelAdded: (String, String, Error?) -> Void

    var onModelDeleted: (String, String) -> Void
    
    var onModelPositionChanged: (String, String, SCNVector3, SCNVector4) -> Void
    
    var onModelSelected: (String, String) -> Void
    
    var onSelectionReset: () -> Void
    
    func makeCoordinator() -> ArSceneView.Coordinator {
        return Coordinator(representable: self, arAdapter: ArAdapter())
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        
        let arAdapter = context.coordinator.arAdapter
        
        arAdapter.managementDelegate = context.coordinator // initialize delegate (ArManagementDelegate
                                                           // protocol) to handle callbacks from ArAdapter
        
        arAdapter.sceneView = view                         // set sceneView in adapter (what used in UI)
        
        arAdapter.modelHighlightingMode = .glow            // type of highlighting of selected models in the scene
                                                           // the following values are supported: .glow, .levitation
                                                           // single tap (on shown 3D object in the scene) selects
                                                           // the model in the scene
        
        arAdapter.glowColor = .blue                        // color of highlighting glow effect
        
        arAdapter.gesturesEnabled = true                   // enable or disable gestures to manage models in the scene
        
        arAdapter.movementEnabled = true                   // enable or disable movements of models in the scene
                                                           // (one and two fingers pan gesture is used to move 3D objects)
        
        arAdapter.rotationEnabled = true                   // enable or disable rotation of 3D objects in the scene
                                                           // (rotate gesture is used for that)
        
        arAdapter.scalingEnabled = true                    // enable or disable scaling of shown 3D objects
                                                           // (pinch gesture is used for that)
        
        arAdapter.snappingsEnabled = true                  // enable or disable snappings features in the scene
                                                           // double tap (on shown snapping area) moves and connects
                                                           // selected model to snapping area.
        
        arAdapter.overlappingOfModelsAllowed = true        // enable or disable ability to move models to
                                                           // positions where other models already placed.
                                                           // if false then ArAdapter doesn't allow to put
                                                           // 3D objects in the overlapped positions.
        
        onInitView(view, arAdapter)
        
        arAdapter.runArSession()
        
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }
    
    static func dismantleUIView(_ uiView: ARSCNView, coordinator: ArSceneView.Coordinator) {
        coordinator.arAdapter.pauseArSession()
    }
    
    final class Coordinator: ArManagementDelegate {
        
        var arAdapter: ArAdapter
    
        private let representable: ArSceneView
        
        init(representable: ArSceneView, arAdapter: ArAdapter) {
            self.representable = representable
            self.arAdapter = arAdapter
        }
        
        func onArShowHelpMessage(type: ArHelpMessageType?, message: String) {
            self.representable.onArShowHelpMessage(type, message)
        }
        
        func onArHideHelpMessage() {
            self.representable.onArHideHelpMessage()
        }
        
        func onAdapterError(error: Error) {
            self.representable.onAdapterError(error)
        }
        
        func onAdapterErrorCritical(error: Error) {
            self.representable.onAdapterErrorCritical(error)
        }
        
        func onArSessionStarted(restarted: Bool) {
            self.representable.onArSessionStarted(restarted)
        }
        
        func onArSessionPaused() {
            self.representable.onArSessionPaused()
        }
        
        func onArUnsupported(message: String) {
            self.representable.onArUnsupported(message)
        }
        
        func onArFirstPlaneDetected(simdWorldPosition: simd_float3) {
            self.representable.onArFirstPlaneDetected(simdWorldPosition)
        }
        
        func onModelAdded(modelId: String, componentId: String, error: Error?) {
            self.representable.onModelAdded(modelId, componentId, error)
        }
        
        func onModelDeleted(modelId: String, componentId: String) {
            self.representable.onModelDeleted(modelId, componentId)
        }
        
        func onModelPositionChanged(modelId: String, componentId: String, position: SCNVector3, rotation: SCNVector4) {
            self.representable.onModelPositionChanged(modelId, componentId, position, rotation)
        }
        
        func onModelSelected(modelId: String, componentId: String) {
            self.representable.onModelSelected(modelId, componentId)
        }
        
        func onSelectionReset() {
            self.representable.onSelectionReset()
        }
    }
}
