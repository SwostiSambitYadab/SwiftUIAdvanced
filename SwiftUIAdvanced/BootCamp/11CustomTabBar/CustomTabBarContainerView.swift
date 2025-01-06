//
//  CustomTabBarContainerView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        _selection = selection
        self.content = content()
    }
    
    
    var body: some View {
        VStack {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

#Preview {
    
    @Previewable
    let tabs: [TabBarItem] = [.home, .favourites, .profile]
    
    
    CustomTabBarContainerView(selection: .constant(tabs[0]),content: {})
}
