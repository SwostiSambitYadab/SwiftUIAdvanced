//
//  CustomCurvesBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 18/12/24.
//

import SwiftUI

struct CustomCurvesBootCamp: View {
    var body: some View {
//        ArcSample()
//        ShapeWithArc()
//        QuadSample()
//        WaterShape()
//            .stroke(lineWidth: 2)
//            .fill(.linearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing))
//            .fill(.yellow)
//            .frame(width: 200, height: 200)
            
        ZStack {
            WaterShape()
                .fill(.linearGradient(colors: [.red, .yellow], startPoint: .leading, endPoint: .trailing))
                .stroke(.linearGradient(colors: [.yellow, .red], startPoint: .leading, endPoint: .trailing),
                        lineWidth: 2)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomCurvesBootCamp()
}
 
 
struct ArcSample: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: .degrees(-20),
                endAngle: .degrees(20),
                clockwise: true
            )
        }
    }
}

struct ShapeWithArc: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // bottom
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: .degrees(0),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            
            // back to top left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            
        }
    }
}

struct QuadSample: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
        }
    }
}


struct WaterShape: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            // we can do like this
//            let quater1st = rect.midX / 2
//            let quater3rd = (rect.midX + rect.maxX) / 2
            
            // or we can use percentage as well
            
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.4)
            )
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY - 50),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6)
            )
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}
