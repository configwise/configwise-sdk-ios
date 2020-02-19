//
//  ComponentThumbnailView.swift
//  ios-example
//
//  Created by Sergey Muravev on 18.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import ConfigWiseSDK

struct ComponentThumbnailView: View {
    
    @ObservedObject private var observableState: ObservableState
    
    private var width: CGFloat
    private var height: CGFloat
    
    init(_ component: ComponentEntity, width: CGFloat = 100, height: CGFloat = 100) {
        self.width = width
        self.height = height
        self.observableState = ObservableState(component)
    }
    
    var body: some View {
        VStack {
            if self.observableState.thumbnailLoadable.isLoading {
                ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                    indicator.style = .medium
                    indicator.hidesWhenStopped = false
                }
            } else {
                Image(uiImage: self.observableState.thumbnailLoadable.value ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: self.width, height: self.height)
    }
}

private class ObservableState: ObservableObject {
    
    @Published var thumbnailLoadable: Loadable<UIImage> = .notRequested
    
    init(_ component: ComponentEntity) {
        self.thumbnailLoadable = .isLoading(last: self.thumbnailLoadable.value)
        component.getThumbnailFileData(block: { [weak self] data, error in
            if let error = error {
                self?.thumbnailLoadable = .failed(error)
                return
            }
            guard let data = data else {
                self?.thumbnailLoadable = .failed("Thumbnail data is nil")
                return
            }
            guard let uiImage = UIImage(data: data) else {
                self?.thumbnailLoadable = .failed("Invalid thumbnail data")
                return
            }

            self?.thumbnailLoadable = .loaded(uiImage)
        })
    }
}
