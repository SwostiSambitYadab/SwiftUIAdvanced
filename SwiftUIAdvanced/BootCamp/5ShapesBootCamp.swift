//
//  ShapesBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 18/12/24.
//

import SwiftUI

/**
  - `path.move` moves the crusor to the cgpoint you want
  - `path.addLine` draws a line to the cgpoint assigned
 */


struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}
 

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            let horizontalOffset = rect.width * 0.1
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        
        Path { path in
            let horizontalOffset = rect.width * 0.2
            
            path.move(to: CGPoint(x: horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: horizontalOffset, y: rect.minY))
            
        }
    }
}
 

struct ShapesBootCamp: View {
    var body: some View {
        
        VStack(spacing: 20) {
            
            Triangle()
//                .stroke(.cyan, lineWidth: 2.0)
//                .stroke(.cyan, style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: [10]))
//                .fill(.linearGradient(colors: [.red, .orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 200, height: 200)
            
            
            Diamond()
                .frame(width: 200, height: 200)
            
            Trapezoid()
                .frame(width: 200, height: 100)
            
        }
    }
}

#Preview {
    ShapesBootCamp()
}
