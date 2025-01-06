//
//  CustomNavBarView.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.dismiss) private var dismiss
    
    let showBackButton: Bool
    let title: String
    let subTitle: String?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .font(.headline)
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
    }
}

#Preview {
    VStack {
        CustomNavBarView(showBackButton: true, title: "", subTitle: nil)
        Spacer()
    }
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subTitle = subTitle {
                Text(subTitle)
            }
        }
    }
}
