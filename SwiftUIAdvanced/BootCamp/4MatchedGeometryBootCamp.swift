//
//  MatchedGeometryBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 18/12/24.
//

import SwiftUI

struct MatchedGeometryBootCamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var animation
    
    var body: some View {
        VStack {
            
            Circle()
                .matchedGeometryEffect(id: "rect", in: animation)
                    .frame(width: 100, height: 100)
            
            Spacer()
            
            if isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rect", in: animation)

                    .frame(width: 300, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    MatchedGeometryBootCamp()
}


struct MatchedGeometryEffectEx2: View {
    
    let categories: [String] = [
        "Home", "Popular", "Saved"
    ]
    @State private var selectedCategory: String = "Home"
    @Namespace private var animation
    
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if selectedCategory == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.pink)
                            .matchedGeometryEffect(id: "category", in: animation)
                            .frame(width: 40, height: 4)
                            .offset(y: 30)
                        
                    }
                    
                    if selectedCategory == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.green.opacity(0.3))
                            .matchedGeometryEffect(id: "category_bg", in: animation)
                    }
                    
                    
                    Text(category)
                        .font(.headline)
                        .foregroundStyle(selectedCategory == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedCategory = category
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    MatchedGeometryEffectEx2()
}
