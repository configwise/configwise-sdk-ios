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
    
    @State var showUnderConstruction = false
    
    struct ErrorStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.red)
                .font(Font.system(size: 18))
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
                    VStack {
                        Text("Loading ...")

                        ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                            // indicator.color = .blue
                            indicator.style = .large
                            indicator.hidesWhenStopped = false
                        }
                    }
                    .padding()
                }
                .modifier(LoadingViewStyle())
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
                VStack {
                    VStack {
                        Text("Loading ...")

                        ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                            // indicator.color = .blue
                            indicator.style = .large
                            indicator.hidesWhenStopped = false
                        }
                    }
                    .padding()
                }
                .modifier(LoadingViewStyle())
            } else {
                Spacer()
                if company.isFailed {
                    Text(company.error?.localizedDescription ?? "Unauthorized.")
                        .modifier(ErrorStyle())
                        .padding(.vertical)
                }
                HStack {
                    Image(systemName: "person.fill")
                    TextField("Email", text: self.$email)
                    .textContentType(.emailAddress)
                }
                HStack {
                    Image(systemName: "lock.fill")
                    SecureField("Password", text: self.$password)
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
                HStack {
                    Button(action: {
                        // TODO [smuravev] Implement 'Forgot password' action here
                        self.showUnderConstruction = true
                    }) {
                        Text("Forgot password")
                    }
                    .alert(isPresented: self.$showUnderConstruction) { () -> Alert in
                        Alert(
                            title: Text("UNDER CONSTRUCTION"),
                            message: Text("We are working hard to implement it asap."),
                            dismissButton: .default(Text("OK")) {
                                self.showUnderConstruction = false
                            }
                        )
                    }
                }
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
