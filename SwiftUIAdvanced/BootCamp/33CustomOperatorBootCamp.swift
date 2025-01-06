//
//  CustomOperatorBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 25/12/24.
//

import SwiftUI

struct CustomOperatorBootCamp: View {
    
    @State private var value: Double = 0
    
    var body: some View {
        Text("\(value)")
            .onAppear {
                // value = 6 ++ 2
                let someValue = 5
                value = someValue => Double.self
            }
    }
}
#Preview {
    CustomOperatorBootCamp()
}

infix operator +/
infix operator ++
infix operator =>

extension FloatingPoint {
    
    static func +/ (lhs: Self, rhs: Self) -> Self {
        (lhs + rhs) / 2
    }
    
    
    static func ++ (lhs: Self, rhs: Self) -> Self {
        (lhs * 2) + rhs
    }
}

protocol initFromBinaryPoint {
    init<Source>(_ value: Source) where Source: BinaryInteger
}

extension Double: initFromBinaryPoint {}

extension BinaryInteger {
    static func => <T: initFromBinaryPoint> (value: Self, newType: T.Type) -> T {
        T(value)
    }
}
