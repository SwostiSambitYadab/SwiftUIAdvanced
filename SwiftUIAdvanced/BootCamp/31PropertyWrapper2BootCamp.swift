//
//  PropertyWrapper2BootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI

// MARK: - Capitalized peoperty wrapper
@propertyWrapper
struct Capitalized: DynamicProperty {
    
    @State private var value: String
    
    init(wrappedValue: String) {
        value = wrappedValue.capitalized
    }
    
    var wrappedValue: String {
        get {
            return value
        } nonmutating set {
            value = newValue.capitalized
        }
    }
    
    var projectedValue: Binding<String> {
        return Binding {
            return wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }    
}

// MARK: - Uppercased peoperty wrapper
@propertyWrapper
struct Uppercased: DynamicProperty {
    
    @State private var title: String
    
    init(wrappedValue: String) {
        title = wrappedValue.uppercased()
    }
    
    var wrappedValue: String {
        get {
            return title
        } nonmutating set {
            title = newValue.uppercased()
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            return wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}

struct User: Codable {
    let name: String
    let age: Int
    let isPremium: Bool
}

struct FileManagerValues {
    static let shared = FileManagerValues()
    private init() {}
    
    let userProfile = FileManagerKeyPath(key: "user_profile", type: User.self)
    
}

struct FileManagerKeyPath<T: Codable> {
    
    let key: String
    let type: T.Type
    
}

// MARK: - FileManagerCodable property wrapper
@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    
    var wrappedValue: T? {
        get {
            return value
        } nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<T?> {
        
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    let key: String
    
    init(_ key: String) {
        self.key = key
        do {
            let data = try Data(contentsOf: FileManager.documentsPath(key))
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: decodedValue)
            debugPrint("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
    
    init(_ keyPath: KeyPath<FileManagerValues, FileManagerKeyPath<T>>) {
        
        let keyPath = FileManagerValues.shared[keyPath: keyPath]
        self.key = keyPath.key
        do {
            let data = try Data(contentsOf: FileManager.documentsPath(key))
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: decodedValue)
            debugPrint("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
    
    
    
    func save(newValue: T?) {
        
        do {
            /**
             `Quick note` ->
                
                - When atomically is set to true, it means that the data will be weitten to a teomporary file first.
             
                - When atomically is set to false, the data is written directly to the specified file path.
             
             */
            
            let encodedValue = try JSONEncoder().encode(newValue)
            try encodedValue.write(to: FileManager.documentsPath(key))
            debugPrint("SUCCESS SAVED")
            value = newValue
        } catch {
            debugPrint("FAILED TO SAVE :: \(error.localizedDescription)")
        }
    }
}

import Combine
/**
    For streamable property wrapper we need to import combine
    - create a CurrentValueSubject publisher
    - initialize it in the init
    - send values in the nonmutating set
    - Instead of passing Binding in projected value return the current value subject
 
    and here we go now listen to changes
 */


struct CustomProjectedValue<T: Codable> {
    
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
}

@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
    
    @State private var value: T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>

    
    var wrappedValue: T? {
        get {
            return value
        } nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: CustomProjectedValue<T> {
        
        CustomProjectedValue(
            binding: Binding(
                get: { wrappedValue },
                set: { wrappedValue = $0 }
            ),
            publisher: publisher)
        
    }
    
    
    init(_ key: String) {
        self.key = key
        do {
            let data = try Data(contentsOf: FileManager.documentsPath(key))
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: decodedValue)
            debugPrint("SUCCESS READ")
            publisher = CurrentValueSubject(decodedValue)
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
    
    init(_ keyPath: KeyPath<FileManagerValues, FileManagerKeyPath<T>>) {
        
        let keyPath = FileManagerValues.shared[keyPath: keyPath]
        self.key = keyPath.key
        do {
            let data = try Data(contentsOf: FileManager.documentsPath(key))
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: decodedValue)
            publisher = CurrentValueSubject(decodedValue)
            debugPrint("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
    
    
    
    private func save(newValue: T?) {
        
        do {
            /**
             `Quick note` ->
                
                - When atomically is set to true, it means that the data will be weitten to a teomporary file first.
             
                - When atomically is set to false, the data is written directly to the specified file path.
             
             */
            
            let encodedValue = try JSONEncoder().encode(newValue)
            try encodedValue.write(to: FileManager.documentsPath(key))
            debugPrint("SUCCESS SAVED")
            value = newValue
            publisher.send(newValue)
        } catch {
            debugPrint("FAILED TO SAVE :: \(error.localizedDescription)")
        }
    }
}


struct PropertyWrapper2BootCamp: View {
        
    @Capitalized private var title: String = "Hello world"
    @Uppercased private var title2: String = "starting title"
    
//    @FileManagerCodableProperty(\.userProfile) private var userProfile
    @FileManagerCodableStreamableProperty(\.userProfile) private var userProfile
    
    var body: some View {
        
        VStack(spacing: 10) {
            Button(userProfile?.name ?? "no value") {
                userProfile = User(name: "Rohit", age: 25, isPremium: true)
            }
            
            Button(title2) {
                title2 = "latest title"
            }
             // ChildWrapper2BootCamp(title: $title, title2: $title2)
            SomeBindingView(user: $userProfile.binding)
            
        }
        .onReceive($userProfile.publisher, perform: { newValue in
            debugPrint("RECEIEVED NEW VALUE OF: \(newValue)")
        })
        .task {
            for await newValue in $userProfile.stream {
                debugPrint("STREAM NEW VALUE IN : \(newValue.publisher)")
            }
        }
        .onAppear {
            debugPrint(NSHomeDirectory())
        }
    }
}

#Preview {
    PropertyWrapper2BootCamp()
}

struct ChildWrapper2BootCamp: View {
    
    @Binding var title: String
    @Binding var title2: String
    
    var body: some View {
        VStack {
            Button(title) {
                title = "value changed"
            }
            
            Button(title2) {
                title2 = "ok bhai tick h bhai"
            }
        }
    }
}

struct SomeBindingView: View {
    
    @Binding var user: User?
    
    var body: some View {
        VStack {
            Button(user?.name ?? "no value") {
                user = User(name: "Some random girl", age: 25, isPremium: true)
            }
        }
    }
}
