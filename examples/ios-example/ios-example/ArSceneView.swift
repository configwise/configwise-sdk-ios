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
    
    var onArSessionError: (Error, String) -> Void
    
    var onArSessionStarted: (Bool) -> Void
    
    var onArSessionPaused: () -> Void
    
    var onArUnsupported: (String) -> Void
    
    var onArFirstPlaneDetected: (simd_float3) -> Void
    
    var onArModelAdded: (String, String, Error?) -> Void
    
    var onModelPositionChanged: (String, String, SCNVector3, SCNVector4) -> Void
    
    var onModelSelected: (String, String) -> Void
    
    var onModelDeleted: (String, String) -> Void
    
    var onSelectionReset: () -> Void
    
    func makeCoordinator() -> ArSceneView.Coordinator {
        return Coordinator(representable: self, arAdapter: ArAdapter())
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        
        let arAdapter = context.coordinator.arAdapter
        
        arAdapter.managementDelegate = context.coordinator
        arAdapter.sceneView = view
        arAdapter.modelHighlightingMode = .glow
        arAdapter.glowColor = .blue
        arAdapter.gesturesEnabled = true
        arAdapter.movementEnabled = true
        arAdapter.rotationEnabled = true
        arAdapter.scalingEnabled = true
        arAdapter.snappingsEnabled = true
        arAdapter.overlappingOfModelsAllowed = true
        
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
        
        func onArSessionError(error: Error, message: String) {
            self.representable.onArSessionError(error, message)
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
        
        func onArModelAdded(modelId: String, componentId: String, error: Error?) {
            self.representable.onArModelAdded(modelId, componentId, error)
        }
        
        func onModelPositionChanged(modelId: String, componentId: String, position: SCNVector3, rotation: SCNVector4) {
            self.representable.onModelPositionChanged(modelId, componentId, position, rotation)
        }
        
        func onModelSelected(modelId: String, componentId: String) {
            self.representable.onModelSelected(modelId, componentId)
        }
        
        func onModelDeleted(modelId: String, componentId: String) {
            self.representable.onModelDeleted(modelId, componentId)
        }
        
        func onSelectionReset() {
            self.representable.onSelectionReset()
        }
    }
}
