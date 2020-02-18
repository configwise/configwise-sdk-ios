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
    
    private let arAdapter: ArAdapter = ArAdapter()
    
    @ObservedObject private var componentData: ComponentData
    
    @State private var componentDataArray = [ComponentData]()
    
    private var selectedComponentData: ComponentData? {
        guard let id = self.arAdapter.selectedModelNode?.id else {
            return nil
        }
        
        return self.componentDataArray.first { $0.id == id }
    }
    
    @State private var criticalErrorMessage: String?
    
    @State private var errorMessage: String?
    
    @State private var helpMessage: String?
    
    @State private var showAddComponentDialog = false

    init(_ component: ComponentEntity) {
        self.componentData = ComponentData(component)
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
            .onReceive(self.componentData.$componentLoadable, perform: { componentLoadable in
                if let error = componentLoadable.error {
                    self.criticalErrorMessage = error.localizedDescription
                    return
                }
            })
            .onReceive(self.componentData.$modelNodeLoadable, perform: { modelNodeLoadable in
                if let error = modelNodeLoadable.error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                if modelNodeLoadable.isLoaded, let model = modelNodeLoadable.value {
                    self.componentDataArray.append(self.componentData)
                    self.arAdapter.addModel(modelNode: model, simdWorldPosition: self.componentData.initialSimdWorldPosition, selectModel: true)
                }
            })
            
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
            trailing: HStack {
                if self.componentData.isLoading {
                    Spacer()
                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .medium
                        indicator.hidesWhenStopped = false
                    }
                    if self.componentData.loadingProgress != nil {
                        Text("\(self.componentData.loadingProgress!)%")
                    }
                } else {
                    self.toolbar
                }
            }
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

            Toggle(isOn: showSizesBinding) { Text("") }
        }
    }
    
    private var addComponentDialog: some View {
        VStack {
            List(self.appEnvironment.components.value ?? []) { component in
                ComponentListItemView(component, selectAction: {
                    self.arAdapter.resetSelection()
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
        if self.componentData.initialSimdWorldPosition == nil {
            self.componentData.initialSimdWorldPosition = simdWorldPosition
        }
        self.componentData.loadModel()
    }
    
    func onArModelAdded(id: String, error: Error?) {
        if let error = error {
            self.componentDataArray.removeAll { $0.id == id }
            self.errorMessage = error.localizedDescription
            return
        }
    }
    
    func onModelPositionChanged(id: String, position: SCNVector3, rotation: SCNVector4) {
    }
    
    func onModelSelected(id: String) {
        refreshOnModelSelection()
    }
    
    func onModelDeleted(id: String) {
        self.componentDataArray.removeAll { $0.id == id }
    }
    
    func onSelectionReset() {
        refreshOnModelSelection()
    }
    
    private func refreshOnModelSelection() {
        self.refreshSnappingAreas()
    }
}

// MARK: - Snappings

// TODO [smuravev] Remove the following code after we move showSnappingAreas() & hideSnappingAreas() functionalities
//                 to CanvasAdapter (ArAdapter) in the ConfigWiseSDK
extension ArView {
    
    private func refreshSnappingAreas() {
        guard let selectedComponentData = self.selectedComponentData else {
            // Hide all snappings if no selected model in AR scene
            self.arAdapter.removeAllSnappings()
            return
        }
        
        // If there is selected model in the AR scene then we show snappings of it
        var snappingsDictionary = [String: [SnappingAreaEntity]]()
        if let selectedComponent = selectedComponentData.component {
            selectedComponent.snappingAreas.forEach {
                let snappingArea = $0
                
                self.arAdapter.modelNodes.filter { modelNode in
                    modelNode.id != selectedComponentData.id
                        && snappingArea.connectToComponentId == selectedComponent.objectId ?? ""
                }.forEach { modelNode in
                    if let id = modelNode.id {
                        var snappings = snappingsDictionary[id]
                        if snappings == nil {
                            snappings = []
                        }
                        snappings?.append(snappingArea)
                        snappingsDictionary[id] = snappings
                    }
                }
            }

            self.arAdapter.addSnappings(modelId: selectedComponentData.id, snappingsDictionary: snappingsDictionary)
        }
    }
}

#if DEBUG
struct ArView_Previews: PreviewProvider {
    static var previews: some View {
        ArView(ComponentEntity())
    }
}
#endif
