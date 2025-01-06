//
//  GenericsBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 19/12/24.
//

import SwiftUI


struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct GenericModel<T> {
    
    let info: T?
    
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}


@Observable
final class GenericsViewModel {
    
    var stringModel = StringModel(info: "Hello world!")
    
    
    var genericStrModel = GenericModel(info: "Generic String")
    var genericIntModel = GenericModel(info: 10)
    var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        
        genericStrModel = genericStrModel.removeInfo()
        genericIntModel = genericIntModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}


struct GenericsBootCamp: View {
    
    @State private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            Text(vm.stringModel.info ?? "no Data")
            
            Text(vm.genericIntModel.info?.description ?? "no Data")
            Text(vm.genericStrModel.info?.description ?? "no Data")
            Text(vm.genericBoolModel.info?.description ?? "no Data")
            
            GenericView(content: Text("custom content"), title: "new View")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootCamp()
}


struct GenericView<T: View>: View {
    
    let content: T
    let title: String
    
    
    var body: some View {
        Text(title)
        content
    }
}
