//
//  UnitTestingBootCampView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 23/12/24.
//

import SwiftUI

/**
 1. Unit Tests
    - test the business logic in your app
 
 2. UI Tests
    - tests the UI of your app
 */


struct UnitTestingBootCampView: View {
    
    @State private var vm: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _vm = State(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootCampView(isPremium: false)
}
