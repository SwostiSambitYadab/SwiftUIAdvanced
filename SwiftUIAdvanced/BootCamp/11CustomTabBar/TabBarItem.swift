//
//  TabBarItem.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

enum TabBarItem: Hashable {
    
    case home, favourites, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favourites:
            return "heart"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favourites:
            return "Favourites"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .red
        case .favourites:
            return .blue
        case .profile:
            return .green
        }
    }
}
