//
//  CustomViewModifiersBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 18/12/24.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(background)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
    }
}

extension View {
    func defaultButton(_ background: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(background: background))
    }
}


struct CustomViewModifiersBootCamp: View {
    var body: some View {
        
        VStack(spacing: 10) {
            Text("Hello, World!")
                .font(.title)
                .defaultButton()
            
            Text("Hello, Everyone!")
                .font(.headline)
                .defaultButton(.red)
            
            Text("How are you!")
                .font(.headline)
                .defaultButton(.pink)
        }
        .padding()
    }
}

#Preview {
    CustomViewModifiersBootCamp()
}
