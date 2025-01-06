//
//  UIViewControllerRepresentableBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 20/12/24.
//

import SwiftUI

struct UIViewControllerRepresentableBootCamp: View {
    
    @State private var showSCreen: Bool = false
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            Button("Click here") {
                showSCreen.toggle()
            }
            
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10, y: 5)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .sheet(isPresented: $showSCreen) {
            UIImagePickerControllerRepresentable(image: $image)
        }
    }
}

#Preview {
    UIViewControllerRepresentableBootCamp()
}

// MARK: - Basic View Controller Representable
struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
        
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyViewController()
        vc.labelText = labelText
        return vc 
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
    }
}


class MyViewController: UIViewController {
    
    var labelText: String = "Starting value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        
        self.view.addSubview(label)
        label.frame = self.view.frame
    }
}


// MARK: - UIImagePicker Controller Representable
struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // swiftui to uikit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // UIkit to swiftui
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image)
    }
    
     class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        
        init(image: Binding<UIImage?>) {
            _image = image
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            picker.dismiss(animated: true) { [weak self] in
                guard let newImage = info[.originalImage] as? UIImage else { return }
                self?.image = newImage
            }
        }
    }
}
