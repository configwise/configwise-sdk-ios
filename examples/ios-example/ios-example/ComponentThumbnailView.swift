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
    
    @ObservedObject var thumbnailData: ComponentThumbnailData
    
    private var width: CGFloat
    private var height: CGFloat
    
    init(_ component: ComponentEntity, width: CGFloat = 100, height: CGFloat = 100) {
        self.width = width
        self.height = height
        self.thumbnailData = ComponentThumbnailData(component)
    }
    
    var body: some View {
        VStack {
            if self.thumbnailData.isLoading {
                ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                    indicator.style = .medium
                    indicator.hidesWhenStopped = false
                }
            } else {
                Image(uiImage: self.thumbnailData.thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: self.width, height: self.height)
    }
}
