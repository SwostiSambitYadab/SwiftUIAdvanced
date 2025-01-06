//
//  AppTabBarView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .onAppear {
                    debugPrint("RED")
                }
                .tabBarItem(.home, selection: $tabSelection)
            
            Color.blue
                .onAppear {
                    debugPrint("BLUE")
                }
                .tabBarItem(.favourites, selection: $tabSelection)
            
            Color.green
                .onAppear {
                    debugPrint("GREEN")
                }
                .tabBarItem(.profile, selection: $tabSelection)
        }
    }
}

#Preview {
    AppTabBarView()
}
