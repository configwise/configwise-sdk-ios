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
        
        var body: some View {
            NavigationView {
                List(self.appEnvironment.components.value ?? []) { component in
                    NavigationLink(destination: CanvasView(component)) {
                        HStack {
                            ComponentThumbnailView(component)
                            VStack(alignment: .leading) {
                                Text(component.appName)
                                    .modifier(NameTextStyle())
                                
                                Text("\(component.totalSize / 1024 / 1024) Mb")
                                    .modifier(SizeTextStyle())
                            }
                        }
                    }
                }
                .onAppear {
                    self.appEnvironment.fetchComponents()
                }
                .navigationBarTitle("Catalog")
                .navigationBarItems(leading: LeadingNavBarItemsView(), trailing: TrailingNavBarItemsView())
            }
        }

        struct ComponentThumbnailView: View {
            
            @ObservedObject var thumbnailImage: ComponentThumbnailImage
            
            init(_ component: ComponentEntity) {
                self.thumbnailImage = ComponentThumbnailImage(component)
            }
            
            var body: some View {
                VStack {
                    if self.thumbnailImage.uiImage.isLoading {
                        ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                            indicator.style = .medium
                            indicator.hidesWhenStopped = false
                        }
                    } else {
                        Image(uiImage: self.thumbnailImage.uiImage.value ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 100, height: 100)
            }
        }
        
        class ComponentThumbnailImage: ObservableObject {
            
            @Published var uiImage: Loadable<UIImage> = .notRequested
            
            init(_ component: ComponentEntity) {
                self.uiImage = .isLoading(last: self.uiImage.value)
                component.getThumbnailFileData(block: { [weak self] data, error in
                    if let error = error {
                        self?.uiImage = .failed(error)
                        return
                    }

                    guard let data = data else {
                        self?.uiImage = .loaded(UIImage())
                        return
                    }

                    self?.uiImage = .loaded(UIImage(data: data) ?? UIImage())
                })
            }
        }
    }
    
    struct AppContentView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            NavigationView {
                Text("UNDER CONSTRUCTION")
                    .navigationBarTitle("AppContent")
                    .navigationBarItems(leading: LeadingNavBarItemsView(), trailing: TrailingNavBarItemsView())
            }
        }
    }
    
    struct TrailingNavBarItemsView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            HStack {
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
    
    struct LeadingNavBarItemsView: View {
        
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View {
            HStack {
                if self.appEnvironment.isLoading {
                    ActivityIndicator(isAnimating: true) { (indicator: UIActivityIndicatorView) in
                        indicator.style = .medium
                        indicator.hidesWhenStopped = false
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
