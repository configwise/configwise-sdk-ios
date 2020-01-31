//
//  SignInView.swift
//  ios-example
//
//  Created by Sergey Muravev on 16.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    @State var email: String = ""
    @State var password: String = ""
    
    struct ErrorStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.red)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    var body: some View {
        switch self.appEnvironment.mode {
        case .B2C:
            return AnyView(self.bodyB2C)
        case .B2B:
            return AnyView(self.bodyB2B)
        }
    }
    
    private var bodyB2C: some View {
        let company = self.appEnvironment.company
        
        return VStack {
            Spacer()
            if company.isFailed {
                Text(company.error?.localizedDescription ?? "Unauthorized.")
                    .modifier(ErrorStyle())
                    .padding(.vertical)
            }
            
            Spacer()
            if company.isLoading {
                VStack {
                    Text("Loading ...")
                        .padding(.vertical)

                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        // indicator.color = .blue
                        indicator.style = .large
                        indicator.hidesWhenStopped = false
                    }
                }
            }
            
            Spacer()
            if company.isFailed || company.isNotRequested {
                Button(action: {
                    self.appEnvironment.signIn()
                }) {
                    Text("Retry")
                }
                .padding(.vertical)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var bodyB2B: some View {
        let company = self.appEnvironment.company

        return VStack {
            if company.isLoading {
                Text("Loading ...")
                    .padding(.vertical)

                ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                    // indicator.color = .blue
                    indicator.style = .large
                    indicator.hidesWhenStopped = false
                }
            } else {
                Spacer()
                if company.isFailed {
                    Text(company.error?.localizedDescription ?? "Unauthorized.")
                        .modifier(ErrorStyle())
                        .padding(.vertical)
                }
                HStack {
                    Text("Email:")
                    TextField("Type your email please", text: self.$email)
                    .textContentType(.emailAddress)
                }
                HStack {
                    Text("Password:")
                    SecureField("Type your password", text: self.$password)
                    .textContentType(.password)
                }
                HStack {
                    Button(action: {
                        self.appEnvironment.signIn(email: self.email, password: self.password)
                    }) {
                        Text("Login")
                    }
                }
                Spacer()
            }
        }
        .padding()
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(AppEnvironment())
    }
}
#endif
