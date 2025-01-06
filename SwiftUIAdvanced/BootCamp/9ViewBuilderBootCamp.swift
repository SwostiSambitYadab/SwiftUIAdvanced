//
//  ViewBuilderBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            

            RoundedRectangle(cornerRadius: 1)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    let title: String
    let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 1)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()

    }
}


struct ViewBuilderBootCamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
            
            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
                        
            HeaderViewGeneric(title: "Generic Title") {
                Text("Hello")
            }
            
            HeaderViewGeneric(title: "Generic Title 2") {
                Image(systemName: "heart.fill")
            }
            
            HeaderViewGeneric(title: "Generic Title 3") {
                HStack {
                    Text("hello")
                    Image(systemName: "bolt.fill")
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
//    ViewBuilderBootCamp()
    LocalViewBuilder(type: .two)
}


struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    private var viewOne: some View {
        Text("One!")

    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart.fill")
        }

    }
    
    private var viewThree: some View {
        Image(systemName: "bolt.fill")
    }
    
    @ViewBuilder
    private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
}
