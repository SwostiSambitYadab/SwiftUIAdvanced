//
//  CustomBindingBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI


/**
 If we don't have @Binding we would have use closures to pass back the values to the parent to child to update the value of parent properties .
 
 - when we are using the `$` sign for binding variables what it actually does is, it create a getter and a setter under the hood and manage that variable accordingly.
 
 - Many times we have to create a @State variable to manage the state of different modifiers like .alert, .confirmationDialouge, .sheet etc. For those cases we might have to manage the boolean states different from the titleKey.
 
 - We could manage both the states without using the boolean state variable by getting and setting the values via. the titlekey variables .
 */


extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init(
            get: {
                value.wrappedValue != nil
            }, set: { newValue in
                if !newValue {
                    value.wrappedValue = nil
                }
            }
        )
    }
}


struct CustomBindingBootCamp: View {
    
    @State var title: String = "Start"
    
    @State private var errorTitle: String? = nil
    // @State private var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            
            ChildView(title: $title)
            
            ChildView2(title: title) { newTitle in
                title = title
            }
            
            ChildView3(title: $title)
            
            ChildView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
            Button("CLICK ME") {
                errorTitle = "NEW ERROR!!!!"
            }
        }
        
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("OK") {
            }
        }
        
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            if !newValue {
//                errorTitle = nil
//            }
//        })) {
//            Button("OK") {
//                
//            }
//        }
        
        
//        .alert(errorTitle ?? "Error", isPresented: $showError) {
//            Button("OK") {
//                
//            }
//        }
    }
}

#Preview {
    CustomBindingBootCamp()
}

struct ChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onTapGesture {
                 title = "NEW TITLE"
            }
    }
}


struct ChildView2: View {
    
    let title: String
    let setTitle: (String) -> Void
    
    var body: some View {
        Text(title)
            .onAppear {
                setTitle("NEW TITLE 2")
            }
    }
}

struct ChildView3: View {
    
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "NEW TITLE 3"
            }
    }
}
