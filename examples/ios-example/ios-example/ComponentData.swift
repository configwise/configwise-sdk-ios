//
//  ComponentData.swift
//  ios-example
//
//  Created by Sergey Muravev on 16.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import SceneKit
import ConfigWiseSDK

class ComponentData: ObservableObject, Identifiable {
    
    @Published var componentLoadable: Loadable<ComponentEntity> = .notRequested
    
    @Published var modelNodeLoadable: Loadable<ModelNode> = .notRequested
    
    @Published var loadingProgress: Int?
    
    var initialSimdWorldPosition: float3?
    
    let id = UUID().uuidString
    
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
        ComponentService.sharedInstance.fetchIfNeededEntity(component) { entity, error in
            if let error = error {
                self.componentLoadable = .failed(error)
                return
            }
            guard let entity = entity else {
                self.componentLoadable = .failed("Fetched component is nil.")
                return
            }
            self.componentLoadable = .loaded(entity)
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
        ModelLoaderService.sharedInstance.loadModelBy(component: component, withModelId: self.id, block: { [weak self] model, error in
            if let error = error {
                delay(0.3) { self?.loadingProgress = nil }
                self?.modelNodeLoadable = .failed(error)
                return
            }
            guard let model = model else {
                delay(0.3) { self?.loadingProgress = nil }
                self?.modelNodeLoadable = .failed("Loaded model is nil")
                return
            }

            delay(0.3) { self?.loadingProgress = nil }
            self?.modelNodeLoadable = .loaded(model)
        }, progressBlock: { [weak self] status, completed in
            self?.loadingProgress = Int(completed * 100)
            if status == .done {
                self?.loadingProgress = 100
            }
        })
    }
}

class ComponentThumbnailData: ObservableObject {
    
    @Published var thumbnailLoadable: Loadable<UIImage> = .notRequested
    
    var thumbnail: UIImage {
        thumbnailLoadable.value ?? UIImage()
    }
    
    var isLoading: Bool {
        thumbnailLoadable.isLoading
    }
    
    init(_ component: ComponentEntity) {
        self.thumbnailLoadable = .isLoading(last: self.thumbnailLoadable.value)
        component.getThumbnailFileData(block: { [weak self] data, error in
            if let error = error {
                self?.thumbnailLoadable = .failed(error)
                return
            }

            guard let data = data else {
                self?.thumbnailLoadable = .loaded(UIImage())
                return
            }

            self?.thumbnailLoadable = .loaded(UIImage(data: data) ?? UIImage())
        })
    }
}
