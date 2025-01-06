//
//  AnyTransitionBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 18/12/24.
//

import SwiftUI

/**
 
 • We can add custom transitions using modifer, asymmetric mmethods.
 
 */ 


struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

// MARK: - Custom Tranistions
extension AnyTransition {
    static var rotating: AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    
    static func rotating(with amount: Double) -> AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    
    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}


struct AnyTransitionBootCamp: View {
    
    @State private var showRectangle: Bool = false
    
    
    var body: some View {
        VStack(spacing: 50) {
            
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(.blurReplace(.upUp))
                    .transition(.rotateOn)
            }
            
            Spacer()
            Text("Click me!")
                .font(.headline)
                .defaultButton()
                .padding(.horizontal, 40)
                .withPressableStyle()
                .onTapGesture {
                    withAnimation(.bouncy) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    AnyTransitionBootCamp()
}
