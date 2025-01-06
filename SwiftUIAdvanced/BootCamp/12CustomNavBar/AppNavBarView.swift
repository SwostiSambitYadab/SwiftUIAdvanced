//
//  AppNavBarView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
//        defaultNavView
        
        customNavView 
    }
}

#Preview {
    AppNavBarView()
}


extension AppNavBarView {
    
    private var defaultNavView: some View {
        NavigationStack {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                        .navigationTitle("Title 2")
                } label: {
                    Text("Navigate")
                }
            }
            .navigationTitle("Nav Title")
        }
    }
    
    private var customNavView: some View {
        CustomNavView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                
                CustomNavLink {
                    Text("Destination")
                        .customNavTitle("Second screen")
                        .customNavSubTitle("subtitle should be showing!")
                } label: {
                    Text("Navigate")
                }
            }            
            .customNavNarItmes(title: "Custom Title!", subTitle: "Custom subtitle", backButtonHidden: true)
        }
    }
}
