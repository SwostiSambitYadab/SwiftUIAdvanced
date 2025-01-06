//
//  ProtocolsBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

struct ProtocolsBootCamp: View {
        
    let colorTheme: ColorThemeProtocol
    let dataSource: DataSourceProtocol
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 10, y: 5)
                .onTapGesture(perform: dataSource.buttonPressed)
        }
    }
}

#Preview {
    ProtocolsBootCamp(colorTheme: AlternativeColorTheme(), dataSource: AlternativeDataSource())
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

extension ColorThemeProtocol {
    var secondary: Color {
        return .white
    }
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .green
    let tertiary: Color = .mint
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .pink
    var tertiary: Color = .indigo
}


protocol DataSourceProtocol {
    var buttonText: String { get }
    
    func buttonPressed()
}

class DefaultDataSource: DataSourceProtocol {
    var buttonText: String = "Protocols are awesome"
    
    func buttonPressed() {
        
    }
}

class AlternativeDataSource: DataSourceProtocol {
    var buttonText: String = "Indeed they are!"
    
    func buttonPressed() {
        
    }
}
