//
//  ScrollViewOffsetPreferenceKeyBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKeyBootCamp: View {
    
    let title: String = "New Title Here!"
    
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .background(
                        GeometryReader { geo in
                            Text("")
                                .scrolledOffset(geo.frame(in: .global).maxY)
                        }
                    )
                contentLayer
            }
        }
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            withAnimation(.spring) {
                self.scrollOffset = value
            }
        }
         .overlay(alignment: .top) {
             if scrollOffset < 0 {
                 navBarLayer
             }
         }
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootCamp()
}

extension ScrollViewOffsetPreferenceKeyBootCamp {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)

    }
    
    
    private var contentLayer: some View {
        ForEach(0..<50) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(.green.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    

    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(.thinMaterial)
    }
}

extension View {
    func scrolledOffset(_ offset: CGFloat) -> some View {
        preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
    }
}


struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
