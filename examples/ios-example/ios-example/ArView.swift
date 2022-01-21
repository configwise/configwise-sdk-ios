//
//  ArView.swift
//  ios-example
//
//  Created by Sergey Muravev on 16.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import ARKit
import ConfigWiseSDK

struct ArView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    @ObservedObject private var observableState = ObservableState()
    
    @State private var arAdapter: ArAdapter?
    
    private var initialComponent: ComponentEntity
    
    @State private var criticalErrorMessage: String?
    
    @State private var errorMessage: String?
    
    @State private var helpMessage: String?
    
    @State private var showAddComponentDialog = false

    init(_ component: ComponentEntity) {
        self.initialComponent = component
    }
    
    struct HelpMessageTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.system(size: 12))
                .padding()
                .multilineTextAlignment(.center)
        }
    }
    
    var body: some View {
        let isErrorMessageBinding = Binding<Bool>(
            get: {
                self.criticalErrorMessage != nil || self.errorMessage != nil
            },
            set: { _ = $0 }
        )
        
        return ZStack {
            ArSceneView(
                arAdapter: $arAdapter,
                
                // This callback function executed when HUD changes visibility (enabled or disabled).
                onHudEnabled: { enabled in
                    guard let arAdapter = self.arAdapter else { return }
                    
                    if enabled {
                        arAdapter.modelMovementEnabled = false
                        arAdapter.modelRotationEnabled = false
                        arAdapter.modelScalingEnabled = false
                    } else {
                        arAdapter.modelMovementEnabled = true
                        arAdapter.modelRotationEnabled = true
                        arAdapter.modelScalingEnabled = true
                    }
                },
                
                // This callback function is executed by ArAdapter when needed to show help message
                // (for better UX experience in your application).
                onArShowHelpMessage: { type, message in
                    DispatchQueue.main.async {
                        self.helpMessage = message
                    }
                },
                
                // Executed if help message must be hidden (for better UX experience).
                onArHideHelpMessage: {
                    DispatchQueue.main.async {
                        self.helpMessage = nil
                    }
                },
                
                // This function executed if non critical AR error occurred.
                onAdapterError: { error in
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                },
                
                // This function executed if critical AR error occurred.
                onAdapterErrorCritical: { error in
                    DispatchQueue.main.async {
                        self.criticalErrorMessage = error.localizedDescription
                    }
                },
                
                // Executed after AR session started.
                onArSessionStarted: { restarted in
                },
                
                // Write your code here if you want to handle event when AR session paused.
                onArSessionPaused: {
                },
                
                // Executed if your device (iPhone / iPad) doesn't support augmented reality
                onArUnsupported: { message in
                    DispatchQueue.main.async {
                        self.criticalErrorMessage = message
                    }
                },
                
                // Executed if AR horizontal plane detected in your room.
                // Usually after AR session starts, user scans room environment (through back camera)
                // by moving phone around the room.
                // First ArAdapter detects AR anchors in the room. Then ArAdapter trying to bind anchors
                // to detect (to create) horizontal planes where we can put our 3D models in the scene.
                // So, after plane detected, ArAdapter informs us about it by callback execution of the current function.
                // Well, on this step we can load and add our 3D model to position of detected plane.
                onArFirstPlaneDetected: { simdWorldPosition in
                    self.addModel(from: self.initialComponent, to: simdWorldPosition)
                },
                
                // Executed if model has been added to AR scene.
                // If model successfully added then 'error' parameter is nil.
                // If failed to add model then 'error' is non nil.
                onModelAdded: { modelId, componentId, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.errorMessage = error.localizedDescription
                        }
                        return
                    }
                },

                // Executed if model has been deleted from AR scene.
                onModelDeleted: { modelId, componentId in
                },
                
                // Executed after 3D model has been moved and/or rotated in the AR scene.
                // Eg: if user moved or rotated selected 3D object using gestures.
                onModelPositionChanged: { modelId, componentId, position, rotation in
                },
                
                // This function is executed by ArAdapter if user selected a model in the scene (by tapping on it).
                onModelSelected: { modelId, componentId in
                    let selectedModel = self.arAdapter?.selectedModel
                    let selectedComponent = self.appEnvironment.getComponentById(componentId)
                    
                    DispatchQueue.main.async {
                        self.observableState.selectedModel = selectedModel
                        self.observableState.selectedComponent = selectedComponent
                    }
                },
                
                // Executed if user selection has been reset on previously selected model.
                onSelectionReset: {
                    self.arAdapter?.hudEnabled = true
                    
                    DispatchQueue.main.async {
                        self.observableState.selectedModel = nil
                        self.observableState.selectedComponent = nil
                    }
                }
            )
            .onAppear {
                func run() {
                    if let arAdapter = self.arAdapter {
                        arAdapter.runArSession()
                        return
                    }
                    delay(0.5) { run() }
                }
                run()
            }
            
            if self.helpMessage != nil {
                VStack {
                    Text(self.helpMessage!)
                        .modifier(HelpMessageTextStyle())
                }
                .background(Color(red: 230.0 / 255.0, green: 243.0 / 255.0, blue: 255.0 / 255.0, opacity: 0.7))
            }
        }
        .alert(isPresented: isErrorMessageBinding) {
            Alert(
                title: Text("ERROR"),
                message: Text(self.criticalErrorMessage ?? self.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK")) {
                    guard self.criticalErrorMessage == nil else {
                        self.criticalErrorMessage = nil
                        self.presentationMode.wrappedValue.dismiss()
                        return
                    }
                    
                    self.errorMessage = nil
                }
            )
        }
        .navigationBarItems(
            trailing: self.toolbar
        )
    }
    
    private var toolbar: some View {
        let showSizesBinding = Binding<Bool>(
            get: {
                self.arAdapter?.showSizes ?? false
            },
            set: {
                self.arAdapter?.showSizes = $0
            }
        )
        
        return HStack {
            // 'Open product link' button
            Button(action: {
                guard let selectedComponent = self.observableState.selectedComponent else {
                    return
                }
                
                ComponentService.sharedInstance.obtainProductUrlByComponentOfCurrentCompany(component: selectedComponent) { productUrl, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        return
                    }
                    guard let productUrl = productUrl else {
                        self.errorMessage = "No external product link."
                        return
                    }
                    
                    UIApplication.shared.open(productUrl, options: [:])
                }
            }) {
                Image(systemName: "safari")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .disabled(self.observableState.selectedComponent == nil || self.observableState.selectedComponent?.productLinkUrl == nil)
            
            Spacer()
            
            // 'Delete' button
            Button(action: {
                if let modelId = self.observableState.selectedModel?.id {
                    self.arAdapter?.removeModelBy(id: modelId)
                }
            }) {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .disabled(self.observableState.selectedModel == nil)

            // 'Add' button
            Button(action: {
                self.showAddComponentDialog = true
            }) {
                Image(systemName: "plus.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .sheet(isPresented: self.$showAddComponentDialog) {
                self.addComponentDialog
            }
            
            Spacer()

            // 'Show / Hide sizes' switcher
            Toggle(isOn: showSizesBinding) { Text("") }
        }
    }
    
    private var addComponentDialog: some View {
        VStack {
            List(self.appEnvironment.components.value ?? []) { component in
                ComponentListItemView(component, selectAction: {
                    self.arAdapter?.resetSelection()
                    self.addModel(from: component)
                    self.showAddComponentDialog = false
                })
            }
            
            Spacer()
            
            Button(action: {
                self.showAddComponentDialog = false
            }) {
                Text("Cancel")
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Loading

extension ArView {
    
    private func addModel(
        from component: ComponentEntity,
        to simdWorldTransform: simd_float4x4? = nil
    ) {
        guard let arAdapter = self.arAdapter else { return }
        
        let componentModel = ComponentModelNode(component: component)
        if simdWorldTransform != nil {
            arAdapter.addModel(modelNode: componentModel, simdWorldTransform: simdWorldTransform!, selectModel: true)
        } else {
            arAdapter.hudEnabled = true
            arAdapter.hud.hudModel = componentModel
        }
    }
}

private class ObservableState: ObservableObject {
    
    @Published var selectedModel: ModelNode?
    
    @Published var selectedComponent: ComponentEntity?
}

#if DEBUG
struct ArView_Previews: PreviewProvider {
    static var previews: some View {
        ArView(ComponentEntity())
    }
}
#endif
