//
//  AnimatableDataBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct AnimatableDataBootCamp: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        
        ZStack {
//            RoundedRectangle(cornerRadius: animate ? 60 : 0)
            
//            RectangelWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
//                .frame(width: 300, height: 300)
            
            Pacman(offsetAmount: animate ? 20 : 0)
                .frame(width: 300, height: 300)
        }
        .onAppear {
            withAnimation(.easeInOut.repeatForever()) {
                animate.toggle()
            }
        }
        
    }
}

#Preview {
    AnimatableDataBootCamp()
}

struct RectangelWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { return cornerRadius }
        set { cornerRadius = newValue }
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: false
            )
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}


struct Pacman: Shape {
        
    var offsetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { return offsetAmount }
        set { offsetAmount = newValue }
    }
    
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: .degrees(offsetAmount),
                endAngle: .degrees(360 - offsetAmount),
                clockwise: false
            )
        }
    }
}
