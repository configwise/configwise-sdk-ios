//
//  CanvasView.swift
//  ios-example
//
//  Created by Sergey Muravev on 23.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import SwiftUI
import SceneKit
import ConfigWiseSDK

struct CanvasView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let canvasAdapter = CanvasAdapter()
    
    @ObservedObject private var observableState: ObservableState

    init(_ component: ComponentEntity) {
        self.observableState = ObservableState(component)
    }
    
    var body: some View {
        let componentDataFailed = Binding<Bool>(
            get: {
                self.observableState.isFailed
            },
            set: { _ = $0 }
        )
        
        let selectedSceneEnvironmentBinding = Binding<SceneEnvironment>(
            get: {
                self.canvasAdapter.sceneEnvironment
            },
            set: {
                self.canvasAdapter.sceneEnvironment = $0
            }
        )
        
        let showSizesBinding = Binding<Bool>(
            get: {
                self.canvasAdapter.showSizes
            },
            set: {
                self.canvasAdapter.showSizes = $0
            }
        )
        
        return ZStack {
            SceneView(
                onInitView: { (view: SCNView) in
                    self.canvasAdapter.sceneView = view
                    self.canvasAdapter.gesturesEnabled = true
                    self.canvasAdapter.cameraControlEnabled = true
                    self.canvasAdapter.groundEnabled = false
                    self.canvasAdapter.resetCameraPropertiesOnFocusToCenter = true
                },
                onUpdateView: { (view: SCNView) in
                }
            )
            .onAppear {
                self.observableState.loadModel()
            }
            .onReceive(self.observableState.$modelNodeLoadable, perform: { modelNodeLoadable in
                if modelNodeLoadable.isLoaded, let model = modelNodeLoadable.value {
                    self.canvasAdapter.addModel(modelNode: model)
                    self.canvasAdapter.focusToCenter(animate: false, resetCameraZoom: true, resetCameraOrientation: true)
                }
            })
            
            if self.observableState.isLoading {
                VStack {
                    VStack {
                        Text("Loading \(self.observableState.loadingProgress != nil ? "\(self.observableState.loadingProgress!)%" : "...")")

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
        .alert(isPresented: componentDataFailed) {
            Alert(
                title: Text("ERROR"),
                message: Text(self.observableState.error?.localizedDescription ?? "Unable to load component data."),
                dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationBarItems(
            trailing: HStack {
                // 'Open product link' button
                Button(action: {
                    guard let component = self.observableState.component else {
                        return
                    }
                    
                    ComponentService.sharedInstance.obtainProductUrlByComponentOfCurrentCompany(component: component) { productUrl, error in
                        if let error = error {
                            print("Unable to open product link due error: \(error.localizedDescription)")
                            return
                        }
                        guard let productUrl = productUrl else {
                            print("Unable to open product link due no product url")
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
                .disabled(!self.observableState.isLoaded || self.observableState.component?.productLinkUrl == nil)

                Spacer()
                
                // 'Scene environment' selector
                Picker(selection: selectedSceneEnvironmentBinding, label: Text("")) {
                    Image(systemName: "sun.max").tag(SceneEnvironment.basicLight)
                    Image(systemName: "moon").tag(SceneEnvironment.basicDark)
                    Image(systemName: "lightbulb").tag(SceneEnvironment.studio)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                // 'Show / Hide sizes' switcher
                Toggle(isOn: showSizesBinding) { Text("") }
            }
        )
    }
}

private class ObservableState: ObservableObject {
    
    @Published var componentLoadable: Loadable<ComponentEntity> = .notRequested
    
    @Published var modelNodeLoadable: Loadable<ModelNode> = .notRequested
    
    @Published var loadingProgress: Int?
    
    var model: ModelNode? {
        modelNodeLoadable.value
    }
    
    var component: ComponentEntity? {
        componentLoadable.value
    }
    
    var isLoading: Bool {
        componentLoadable.isLoading || modelNodeLoadable.isLoading
    }
    
    var isLoaded: Bool {
        componentLoadable.isLoaded && modelNodeLoadable.isLoaded
    }
    
    var isFailed: Bool {
        componentLoadable.isFailed || modelNodeLoadable.isFailed
    }
    
    var error: Error? {
        componentLoadable.error ?? modelNodeLoadable.error
    }
    
    init(_ component: ComponentEntity) {
        self.componentLoadable = .isLoading(last: component)
        guard let componentId = component.objectId else {
            self.componentLoadable = .failed("Invalid component - no identifier found.")
            return
        }
        ComponentService.sharedInstance.obtainComponentById(id: componentId) { component, error in
            if let error = error {
                self.componentLoadable = .failed(error)
                return
            }
            guard let component = component else {
                self.componentLoadable = .failed("Fetched component is nil.")
                return
            }
            self.componentLoadable = .loaded(component)
        }
    }
    
    func loadModel() {
        self.modelNodeLoadable = .isLoading(last: self.modelNodeLoadable.value)

        guard !componentLoadable.isFailed else {
            self.modelNodeLoadable = .failed(componentLoadable.error!)
            return
        }
        guard let component = self.componentLoadable.value else {
            self.modelNodeLoadable = .failed("Unable to load model due component is nil.")
            return
        }

        self.loadingProgress = 0
        ModelLoaderService.sharedInstance.loadModelBy(component: component, block: { [weak self] model, error in
            self?.loadingProgress = 100
            delay(0.3) { self?.loadingProgress = nil }
            
            if let error = error {
                self?.modelNodeLoadable = .failed(error)
                return
            }
            guard let model = model else {
                self?.modelNodeLoadable = .failed("Loaded model is nil")
                return
            }

            self?.modelNodeLoadable = .loaded(model)
        }, progressBlock: { [weak self] status, completed in
            self?.loadingProgress = Int(completed * 100)
        })
    }
}

#if DEBUG
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(ComponentEntity())
    }
}
#endif
