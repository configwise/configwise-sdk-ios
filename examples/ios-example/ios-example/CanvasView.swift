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
    
    @ObservedObject private var componentData: ComponentData

    init(_ component: ComponentEntity) {
        self.componentData = ComponentData(component)
    }
    
    var body: some View {
        let componentDataFailed = Binding<Bool>(
            get: {
                self.componentData.isFailed
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
                self.componentData.loadModel()
            }
            .onReceive(self.componentData.$modelNodeLoadable, perform: { modelNodeLoadable in
                if modelNodeLoadable.isLoaded, let model = modelNodeLoadable.value {
                    self.canvasAdapter.addModel(modelNode: model)
                    self.canvasAdapter.focusToCenter(animate: false, resetCameraZoom: true, resetCameraOrientation: true)
                }
            })
        }
        .alert(isPresented: componentDataFailed) {
            Alert(
                title: Text("ERROR"),
                message: Text(self.componentData.error?.localizedDescription ?? "Unable to load component data."),
                dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
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
                    Picker(selection: selectedSceneEnvironmentBinding, label: Text("")) {
                        Image(systemName: "sun.max").tag(SceneEnvironment.basicLight)
                        Image(systemName: "moon").tag(SceneEnvironment.basicDark)
                        Image(systemName: "lightbulb").tag(SceneEnvironment.studio)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    Toggle(isOn: showSizesBinding) { Text("") }
                }
            }
        )
    }
}

#if DEBUG
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(ComponentEntity())
    }
}
#endif
