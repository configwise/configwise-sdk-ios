//
//  ActivityIndicator.swift
//  ios-example
//
//  Created by Sergey Muravev on 29.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    
    var isAnimating: Bool
    
    var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        self.isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        self.configuration(uiView)
    }
    
}

// With this little helpful extension, you can access the configuration through a modifier like other SwiftUI views
extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
