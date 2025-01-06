//
//  KeyPathsBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI

/**
    - we can use keypath to fetch values of a property from class or a struct .
 ```
 e.g, If we need to get name of an employee object we can retrieve it by 2 methods
 - employee.name
 - employee[keyPath: \.name]
 
 both the ways gives you the same answer .
 ```
 
 - We can use the keyPath method for apple APIs, we'll use them when we are creating custom poperty wrappers.
 
 */

struct MyDataModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

struct MovieTitle {
    let primary: String
    let secondary: String
}


extension Array {
    
    mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return ascending ? value1 < value2  : value1 > value2
        }
    }
    
    
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? value1 < value2 : value1 > value2
        }
    }
}

struct KeyPathsBootCamp: View {
    
    // @Environment(\.dismiss) private var dismiss
    @AppStorage("user_count") var userCount: Int = 0
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        List(dataArray) { item in
            VStack(alignment: .leading) {
                Text(item.id)
                Text(item.title)
                Text("\(item.count)")
                Text(item.date.description)
            }
            .font(.headline)
        }
        .onAppear {
            var array = [
                MyDataModel(title: "Three", count: 3, date: .distantFuture),
                MyDataModel(title: "One", count: 1, date: .now),
                MyDataModel(title: "Two", count: 2, date: .distantPast),
            ]
            
//            let newArray = array.sorted(by: { $0[keyPath: \.count] < $1[keyPath: \.count] })
            
            // let newArray = array.sortedByKeyPath(\.count, ascending: false)
             
//            array.sort { item1, item2 in
//                return item1.count < item2.count
//            }
            
            array.sortByKeyPath(\.count, ascending: false)
            
            dataArray = array
        }
    }
}
  
#Preview {
    KeyPathsBootCamp()
}
