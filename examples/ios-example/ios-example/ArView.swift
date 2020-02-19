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
    
    private let arAdapter: ArAdapter = ArAdapter()
    
    private var initialComponent: ComponentEntity
    
    @State private var isLoading = false
    
    @State private var loadingProgress: Int?
    
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
                onInitView: { (view: ARSCNView) in
                    self.arAdapter.managementDelegate = self
                    self.arAdapter.sceneView = view
                    self.arAdapter.modelHighlightingMode = .glow
                    self.arAdapter.glowColor = .blue
                    self.arAdapter.gesturesEnabled = true
                    self.arAdapter.movementEnabled = true
                    self.arAdapter.rotationEnabled = true
                    self.arAdapter.scalingEnabled = true
                    self.arAdapter.snappingsEnabled = true
                    self.arAdapter.overlappingOfModelsAllowed = true
                },
                onUpdateView: { (view: ARSCNView) in
                }
            )
            .onAppear {
                self.arAdapter.runArSession()
            }
            .onDisappear {
                self.arAdapter.pauseArSession()
            }
            
            if self.helpMessage != nil {
                VStack {
                    Text(self.helpMessage!)
                        .modifier(HelpMessageTextStyle())
                }
                .background(Color(red: 230.0 / 255.0, green: 243.0 / 255.0, blue: 255.0 / 255.0, opacity: 0.7))
            }
            
            if self.isLoading {
                VStack {
                    VStack {
                        Text("Loading \(self.loadingProgress != nil ? "\(self.loadingProgress!)%" : "...")")

                        ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                            indicator.style = .large
                            indicator.hidesWhenStopped = false
                        }
                    }
                    .padding()
                }
                .modifier(LoadingViewStyle())
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
                self.arAdapter.showSizes
            },
            set: {
                self.arAdapter.showSizes = $0
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
                    self.arAdapter.removeModelBy(id: modelId)
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
                    self.arAdapter.resetSelection()
                    self.addModel(of: component)
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
    
    private func addModel(of component: ComponentEntity, to simdWorldPosition: float3? = nil) {
        self.isLoading = true
        self.loadingProgress = 0
        ModelLoaderService.sharedInstance.loadModelBy(component: component, block: { model, error in
            self.loadingProgress = 100
            delay(0.3) {
                self.isLoading = false
                self.loadingProgress = nil
            }

            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            guard let model = model else {
                self.errorMessage = "Loaded model is nil"
                return
            }
            
            self.arAdapter.addModel(modelNode: model, simdWorldPosition: simdWorldPosition, selectModel: true)
        }, progressBlock: { status, completed in
            self.loadingProgress = Int(completed * 100)
        })
    }
}

// MARK: - AR

extension ArView: ArManagementDelegate {
    
    func onArShowHelpMessage(type: ArHelpMessageType?, message: String) {
        self.helpMessage = message
    }
    
    func onArHideHelpMessage() {
        self.helpMessage = nil
    }
    
    func onArSessionError(error: Error, message: String) {
        self.criticalErrorMessage = !message.isEmpty ? message : error.localizedDescription
    }
    
    func onArSessionInterrupted(message: String) {
    }
    
    func onArSessionInterruptionEnded(message: String) {
    }
    
    func onArSessionStarted(restarted: Bool) {
    }
    
    func onArSessionPaused() {
    }
    
    func onArUnsupported(message: String) {
        self.criticalErrorMessage = message
    }
    
    func onArPlaneDetected(simdWorldPosition: float3) {
        self.addModel(of: self.initialComponent, to: simdWorldPosition)
    }
    
    func onArModelAdded(modelId: String, componentId: String, error: Error?) {
        if let error = error {
            self.errorMessage = error.localizedDescription
            return
        }
    }
    
    func onModelPositionChanged(modelId: String, componentId: String, position: SCNVector3, rotation: SCNVector4) {
    }
    
    func onModelSelected(modelId: String, componentId: String) {
        self.observableState.selectedModel = self.arAdapter.selectedModelNode
        self.observableState.selectedComponent = self.appEnvironment.getComponentById(componentId)
    }
    
    func onModelDeleted(modelId: String, componentId: String) {
    }
    
    func onSelectionReset() {
        self.observableState.selectedModel = nil
        self.observableState.selectedComponent = nil
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
