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
    
    @State private var canvasAdapter: CanvasAdapter?
    
    @State private var componentModel: ComponentModelNode?
    
    init(_ component: ComponentEntity) {
        self.componentModel = ComponentModelNode(component: component)
    }
    
    var body: some View {
        let componentDataFailed = Binding<Bool>(
            get: {
                self.componentModel?.loadableState.isFailed ?? false
            },
            set: { _ = $0 }
        )
        
        let selectedSceneEnvironmentBinding = Binding<SceneEnvironment?>(
            get: {
                self.canvasAdapter?.sceneEnvironment
            },
            set: {
                if let value = $0 {
                    self.canvasAdapter?.sceneEnvironment = value
                }
            }
        )
        
        let showSizesBinding = Binding<Bool>(
            get: {
                self.canvasAdapter?.showSizes ?? false
            },
            set: {
                self.canvasAdapter?.showSizes = $0
            }
        )
        
        return ZStack {
            SceneView(canvasAdapter: $canvasAdapter)
                .onAppear {
                    func loadModel() {
                        guard let canvasAdapter = self.canvasAdapter else {
                            delay(0.5) { loadModel() }
                            return
                        }
                        
                        guard let componentModel = self.componentModel else { return }
                        
                        canvasAdapter.addModel(modelNode: componentModel) {
                            canvasAdapter.focusToCenter(animate: false, resetCameraZoom: true, resetCameraOrientation: true)
                        }
                    }
                }
            
            if self.componentModel?.loadableState.isLoading ?? false {
                VStack {
                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .large
                        indicator.hidesWhenStopped = false
                    }
                    .padding()
                }
                .modifier(LoadingViewStyle())
            }
        }
        .alert(isPresented: componentDataFailed) {
            Alert(
                title: Text("ERROR"),
                message: Text(self.componentModel?.loadableState.error?.localizedDescription ?? "Unable to load component data."),
                dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationBarItems(
            trailing: HStack {
                // 'Open product link' button
                Button(action: {
                    guard let component = self.componentModel?.component else { return }
                    
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
                .disabled(!(self.componentModel?.loadableState.isLoaded ?? false)
                            || self.componentModel?.component.productLinkUrl == nil)

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

#if DEBUG
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(ComponentEntity())
    }
}
#endif
