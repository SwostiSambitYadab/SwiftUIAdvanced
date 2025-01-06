//
//  CustomNavLink.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let label: Label
    let destination: Destination
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.destination = destination()
    }
    
    
    var body: some View {
        
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        } label: {
            label
        }
    }
}

#Preview {
    
    CustomNavView {
        CustomNavLink {
            Text("Destination")
        } label: {
            Text("Label")
        }
    }
}
