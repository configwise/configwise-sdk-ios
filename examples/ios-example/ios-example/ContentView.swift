//
//  ContentView.swift
//  ios-example
//
//  Created by Sergey Muravev on 23.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        ZStack {
            if self.appEnvironment.navigation == .signIn {
                SignInView()
            } else if self.appEnvironment.navigation == .main {
                MainView()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppEnvironment())
    }
}
#endif
