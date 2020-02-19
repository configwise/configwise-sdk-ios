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
                    if self.appEnvironment.openDetailedViewAs == .ar {
                        NavigationLink(destination: ArView(component)) {
                            ComponentListItemView(component)
                        }
                    } else {
                        NavigationLink(destination: CanvasView(component)) {
                            ComponentListItemView(component)
                        }
                    }
                }
                .onAppear {
                    self.appEnvironment.obtainComponents()
                }
                .navigationBarTitle("Catalog")
                .navigationBarItems(trailing: TrailingNavBarItemsView())
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    struct AppContentView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            NavigationView {
                Text("UNDER CONSTRUCTION")
                    .navigationBarTitle("AppContent")
                    .navigationBarItems(trailing: TrailingNavBarItemsView())
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    struct TrailingNavBarItemsView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {

            let openDetailedViewAsBinding = Binding<OpenDetailedViewAs>(
                get: {
                    self.appEnvironment.openDetailedViewAs
                },
                set: {
                    self.appEnvironment.openDetailedViewAs = $0
                }
            )
            
            return HStack {
                if self.appEnvironment.isLoading {
                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .medium
                        indicator.hidesWhenStopped = false
                    }
                } else {
                    Picker(selection: openDetailedViewAsBinding, label: Text("")) {
                        Image(systemName: "arkit").tag(OpenDetailedViewAs.ar)
                        Image(systemName: "cube").tag(OpenDetailedViewAs.canvas)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if self.appEnvironment.mode == .B2B {
                        Spacer()
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
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppEnvironment())
    }
}
#endif
