//
//  DependencyInjectionBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 23/12/24.
//

import SwiftUI

// References
// https://jsonplaceholder.typicode.com/posts
/*
 {
     "userId": 1,
     "id": 1,
     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
   }
 */


/**
 -> PROBLEMS WITH SINGLETONS
    1. Singletons are global
    2. Can't customize the init!
    3. Can't swap out dependency
 
 */

struct PostsModel: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}

protocol DataServiceProtocol {
    func getData() async throws -> [PostsModel]?
}

class ProductionDataservice: DataServiceProtocol {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() async throws -> [PostsModel]? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([PostsModel].self, from: data)
            return decodedData

        } catch {
            throw error
        }
    }
}


class MockDataService: DataServiceProtocol {
    
    let mockData: [PostsModel]
    
    init(data: [PostsModel]? = nil) {
        self.mockData = data ??
        [
            .init(userId: 1, id: 10, title: "hello", body: "how are you"),
            .init(userId: 2, id: 11, title: "ohh hi", body: "I'm fine"),
            .init(userId: 3, id: 12, title: "bye", body: "see you soon"),
        ]
    }
    
    func getData() async throws -> [PostsModel]? {
        return mockData
    }
}

@Observable
class DependencyInjectionViewModel {
    
    var dataArray: [PostsModel] = []
    private let dataService: DataServiceProtocol
    
    init(_ service: DataServiceProtocol) {
        self.dataService = service
        Task {
            await loadPosts()
        }
    }
    
    private func loadPosts() async {
        do {
            let postsModel = try await dataService.getData()
            self.dataArray = postsModel ?? []
        } catch {
            debugPrint("Error :: \(error.localizedDescription)")
        }
    }
}


struct DependencyInjectionBootCamp: View {
    
    @State private var vm: DependencyInjectionViewModel
    
    init(_ dataService: DataServiceProtocol) {
        _vm = State(wrappedValue: DependencyInjectionViewModel(dataService))
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let service = ProductionDataservice(url: url)
//    let mockService = MockDataService(data: [.init(userId: 1, id: 1, title: "ONE", body: "ONE")])
//    DependencyInjectionBootCamp(mockService)
    DependencyInjectionBootCamp(service)
}
