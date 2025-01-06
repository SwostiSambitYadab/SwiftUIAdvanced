//
//  UIViewRepresentableBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI

struct UIViewRepresentableBootCamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            
            Text(text)
            
            HStack {
                Text("SwiftUI:")
                TextField("Type here....", text: $text)
                    .frame(height: 55)
                    .background(.gray)
            }
            
            HStack {
                Text("UIKit:    ")
                
                UITextfieldViewRepresentable(text: $text)
                    .updatePlaceholder("new placeholder..")
                    .frame(height: 55)  
                    .background(.gray)
            }
        }
    }
}

#Preview {
    UIViewRepresentableBootCamp()
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}


struct UITextfieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor

    
    init(text: Binding<String>, placeholder: String = "default placeholder...", placeholderColor: UIColor = .red) {
        _text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    
    // form uikit to swiftui
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // from siwftui to uikit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor
            ])
        
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> UITextfieldViewRepresentable {
        
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
}

