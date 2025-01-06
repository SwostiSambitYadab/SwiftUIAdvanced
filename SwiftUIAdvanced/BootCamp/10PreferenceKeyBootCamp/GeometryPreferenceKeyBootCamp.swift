//
//  GeometryPreferenceKeyBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

/**
  - Steps to use `Preference Keys`
 
    • Create a struct conforming `PreferenceKey` protocol
 
    • assign the default value to the type you want
 
    • In the reduce method use the `nextValue()` method to assign the appropriate value to the inout parameter `value`
 
    • Extend the view and make a function to pass the preference key value using `preference(key: PreferenceKey.self, value: Value)`
 
    • And in the parent view add the method `onPreferenceChange` to handle the value that we are passing from the child view using `preference key` .
 */


struct GeometryPreferenceKeyBootCamp: View {
    
    @State private var rectSize: CGSize = .zero

    
    var body: some View {
                
        VStack {
            
            Spacer()
            
            Text("Hello world")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(.cyan)
                .overlay {
                    HStack {
                        Text("\(rectSize.width)")
                        Text("\(rectSize.height)")
                    }
                    .offset(y: 50)
                }
            
            Spacer()
            Spacer()
            Spacer()
            
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .overlay {
                            Text("\(geo.size.width)")
                                .foregroundStyle(.white)
                        }
                        .rectangleSize(geo.size)
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangelGeometryPreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

#Preview {
    GeometryPreferenceKeyBootCamp()
}


struct RectangelGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func rectangleSize(_ size: CGSize) -> some View {
        preference(key: RectangelGeometryPreferenceKey.self, value: size)
    }
}
