//
//  PropertyWrapperBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI

/**
    - We can make a struct a property wrapper by adding `@propertyWrapper` macro and confirming to `DynamicProperty` protocol.
 
    - Basically DynamicProperty make the compiler understand that there is a value inside the struct which might effect the view to rerender.
 
    - When we use the macro `@propertyWrapper`, we need to add a `wrappedValue` variable which will have a `getter` and a `non-mutating setter` .
 
    - Here the non-mutating setter refers that we don't need to mutate the whole struct we just need to update the dynamic property that is present inside the struct .
 
    - `$` sign in @Binding variables are nothing but `projectedValue` which we can access from the struct.
 */

extension FileManager {
    static func documentsPath(_ key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: key)
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    
    var wrappedValue: String {
        get {
            return title
        } nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            return wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
    
    let key: String
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            let savedTitle = try String(contentsOf: FileManager.documentsPath(key), encoding: .utf16)
            title = savedTitle
            debugPrint("SUCCESS READ")
        } catch {
            title = wrappedValue
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
    
    func save(newValue: String) {
        
        do {
            /**
             `Quick note` ->
                
                - When atomically is set to true, it means that the data will be weitten to a teomporary file first.
             
                - When atomically is set to false, the data is written directly to the specified file path.
             
             */
            
            try newValue.write(to: FileManager.documentsPath(key), atomically: false, encoding: .utf16)
            debugPrint("SUCCESS SAVED")
            title = newValue
        } catch {
            debugPrint("FAILED TO SAVE :: \(error.localizedDescription)")
        }
    }
}

struct PropertyWrapperBootCamp: View {
    
    @FileManagerProperty("title1") private var title: String = "Starting text"
    @FileManagerProperty("title2") private var title2: String = "Starting text2"
    @FileManagerProperty("title3") private var title3: String = "Starting text3"
    
    @State private var subTitle: String = "SUBTITLE"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
            
            Text(title2)
                .font(.largeTitle)
            
            Text(title3)
                .font(.largeTitle)
            
            PropertyWrapperChildView(subTitle: $title)

            Button("Click me 1") {
                title = "Title1"
                title2 = "Some other title"
            }
            
            Button("Click me 2") {
                title = "Some title"
                title2 = "Title2"
            }
        }
    }
}

#Preview {
    PropertyWrapperBootCamp()
}


struct PropertyWrapperChildView: View {
    
    @Binding var subTitle: String
    
    var body: some View {
        Button {
            subTitle = "Another SubTitle!!!"
        } label: {
            Text(subTitle)
                .font(.largeTitle)
        }
    }
}
