//
//  ComponentListItemView.swift
//  ios-example
//
//  Created by Sergey Muravev on 18.02.2020.
//  Copyright © 2020 VipaHelda BV. All rights reserved.
//

import SwiftUI
import ConfigWiseSDK

struct ComponentListItemView: View {
    
    var component: ComponentEntity
    
    var selectAction: (() -> Void)?
    
    private var thumbnailWidth: CGFloat
    private var thumbnailHeight: CGFloat
    
    private struct NameTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.system(size: 16))
                .padding(.vertical)
        }
    }
    
    private struct SizeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.gray)
                .font(Font.system(size: 12))
                .padding(.vertical)
        }
    }
    
    init(
        _ component: ComponentEntity,
        thumbnailWidth: CGFloat = 100,
        thumbnailHeight: CGFloat = 100
    ) {
        self.thumbnailWidth = thumbnailWidth
        self.thumbnailHeight = thumbnailHeight
        self.component = component
    }
    
    init(
        _ component: ComponentEntity,
        thumbnailWidth: CGFloat = 100,
        thumbnailHeight: CGFloat = 100,
        selectAction: @escaping () -> Void
    ) {
        self.thumbnailWidth = thumbnailWidth
        self.thumbnailHeight = thumbnailHeight
        self.component = component
        
        self.selectAction = selectAction
    }
    
    var body: some View {
        HStack {
            ComponentThumbnailView(self.component, width: thumbnailWidth, height: thumbnailHeight)

            Button(action: {
                if let selectAction = self.selectAction {
                    selectAction()
                }
            }) {
                VStack(alignment: .leading) {
                    Text(self.component.genericName)
                        .modifier(NameTextStyle())
                    
                    Text("\(self.component.totalSize / 1024 / 1024) Mb")
                        .modifier(SizeTextStyle())
                }
            }
        }
    }
}
