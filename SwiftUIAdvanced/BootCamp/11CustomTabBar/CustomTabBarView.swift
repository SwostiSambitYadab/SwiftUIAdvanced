//
//  CustomTabBarView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var animation
    
    var body: some View {
        tabBarV2
    }
    
    private func switchTab(tab: TabBarItem) {
        withAnimation(.spring) {
            selection = tab
        }
    }
}

#Preview {
    @Previewable
    let tabs: [TabBarItem] = [.home, .favourites, .profile]
    
    VStack {
        Spacer()
        CustomTabBarView(tabs: tabs, selection: .constant(tabs[0]))
    }
}


// MARK: - Version 1
extension CustomTabBarView {
    
    private func tabView(_ tabBarItem: TabBarItem) -> some View {
        VStack {
            Image(systemName: tabBarItem.iconName)
                .font(.subheadline)
            Text(tabBarItem.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tabBarItem ? tabBarItem.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tabBarItem ? tabBarItem.color.opacity(0.3) : .clear)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    private var tabBarV1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tabItem in
                tabView(tabItem)
                    .onTapGesture {
                        switchTab(tab: tabItem)
                    }
            }
        }
        .padding(6)
        .background(.white)
    }
}


// MARK: - Version 2
extension CustomTabBarView {
    private func tabView2(_ tabBarItem: TabBarItem) -> some View {
        VStack {
            Image(systemName: tabBarItem.iconName)
                .font(.subheadline)
            Text(tabBarItem.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tabBarItem ? tabBarItem.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if selection == tabBarItem {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tabBarItem.color.opacity(0.3))
                        .matchedGeometryEffect(id: "tab_bg", in: animation)
                }
            }
        )
    }
    
    
    private var tabBarV2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tabItem in
                tabView2(tabItem)
                    .onTapGesture {
                        switchTab(tab: tabItem)
                    }
            }
        }
        .padding(6)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
        .padding(.horizontal)
    }
}
