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
    
    var component: ComponentEntity
    
    private let canvasAdapter = CanvasAdapter()
    
    @ObservedObject private var componentModel: ComponentModel
    
    @State private var selectedSceneEnvironment: SceneEnvironment = .basicLight
    
    private var sceneEnvironmentIcon = [ "sun.max", "moon", "lightbulb" ]
    
    @State private var showDimensions = false

    init(_ component: ComponentEntity) {
        self.component = component
        self.componentModel = ComponentModel(component)
    }
    
    var body: some View {
        let modelNodeLoadable = self.componentModel.modelNodeLoadable
        
        let selectedSceneEnvironmentBinding = Binding<SceneEnvironment>(
            get: {
                self.selectedSceneEnvironment
            },
            set: {
                self.selectedSceneEnvironment = $0
                self.canvasAdapter.sceneEnvironment = $0
            }
        )
        
        let showDimensionsBinding = Binding<Bool>(
            get: {
                self.showDimensions
            },
            set: {
                self.showDimensions = $0
                if $0 {
                    self.canvasAdapter.enableMeasurementUnits()
                } else {
                    self.canvasAdapter.disableMeasurementsUnits()
                }
            }
        )
        
        return ZStack(alignment: .top) {
            if modelNodeLoadable.isLoading || modelNodeLoadable.isNotRequested {
                VStack {
                    Text("Loading \(self.componentModel.loadingProgress)%")
                        .padding(.vertical)

                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .medium
                        indicator.hidesWhenStopped = false
                    }
                }
            } else if modelNodeLoadable.isFailed {
                VStack {
                    Text("ERROR:")
                        .foregroundColor(.red)
                        .font(Font.system(size: 18))

                    Text(modelNodeLoadable.error?.localizedDescription ?? "Unable to load model.")
                        .foregroundColor(.red)
                        .font(Font.system(size: 14))
                }
            } else if modelNodeLoadable.isLoaded {
                SceneView { (scnView: SCNView) in
                    // Let's setup canvasAdapter here
                    self.canvasAdapter.sceneView = scnView
                    self.canvasAdapter.enableGestures()
                    self.canvasAdapter.enableCameraControl()
                    self.canvasAdapter.disableGround()
                    self.canvasAdapter.resetCameraPropertiesOnFocusToCenter = true
                }
                .onAppear {
                    self.canvasAdapter.removeModels()

                    guard let modelNode = modelNodeLoadable.value else {
                        return
                    }

                    self.canvasAdapter.addModel(
                        modelNode: modelNode,
                        notifyCanvasManagementDelegate: false
                    )

                    self.canvasAdapter.focusToCenter(animate: false, resetCameraZoom: true, resetCameraOrientation: true)
                }
            }
        }
        .onAppear {
            self.componentModel.load()
        }
        .navigationBarItems(
            trailing: HStack {
                Picker(selection: selectedSceneEnvironmentBinding, label: Text("")) {
                    ForEach(SceneEnvironment.allCases.indices) {
                        Image(systemName: self.sceneEnvironmentIcon[$0]).tag(SceneEnvironment.allCases[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
                Toggle(isOn: showDimensionsBinding) { Text("") }
            }
        )
    }
    
    class ComponentModel: ObservableObject {
        
        @Published var modelNodeLoadable: Loadable<CNVModelNode> = .notRequested
        
        @Published var loadingProgress = 0
        
        private var component: ComponentEntity
        
        init(_ component: ComponentEntity) {
            self.component = component
        }
        
        func load() {
            self.loadingProgress = 0
            self.modelNodeLoadable = .isLoading(last: self.modelNodeLoadable.value)
            ModelLoaderService.sharedInstance.loadModelBy(component: self.component, block: { [weak self] model, error in
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
                if status == .done {
                    self?.loadingProgress = 100
                }
            })
        }
    }
}

#if DEBUG
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(ComponentEntity())
    }
}
#endif
