//
//  MainView.swift
//  ios-example
//
//  Created by Sergey Muravev on 27.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import SwiftUI
import ConfigWiseSDK

struct MainView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        TabView {
            CatalogView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2")
                    Text("Catalog")
                }

            AppContentView()
            .tabItem {
                Image(systemName: "rectangle.grid.2x2")
                Text("AppContent")
            }
        }
    }
    
    struct CatalogView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            NavigationView {
                List(self.appEnvironment.components.value ?? []) { component in
                    Text(component.appName)
                }
                .onAppear {
                    self.appEnvironment.fetchComponents()
                }
                .navigationBarTitle("Catalog")
                .navigationBarItems(trailing: NavBarItemsView())
            }
        }
    }
    
    struct AppContentView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            NavigationView {
                Text("UNDER CONSTRUCTION")
                .navigationBarTitle("AppContent")
                .navigationBarItems(trailing: NavBarItemsView())
            }
        }
    }
    
    struct NavBarItemsView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            HStack {
                if self.appEnvironment.isLoading {
                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .medium
                        indicator.hidesWhenStopped = false
                    }
                }
                
                if self.appEnvironment.mode == .B2B {
                    Button(action: {
                        AuthService.sharedInstance.signOut()
                    }) {
                        Text("Logout")
                    }
                }
            }
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppEnvironment())
    }
}
#endif
