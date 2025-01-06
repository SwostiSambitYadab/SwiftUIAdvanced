//
//  FuturesBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 23/12/24.
//

import SwiftUI
import Combine

// download with Combine
// download with @escaping closure
// convert @escaping closure to Combine


@Observable
final class FuturesViewModel {
    var title: String = "Starting Title"
    private let url = URL(string: "https://www.google.com")!
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        /// - Using Combine publisher
        /*
            getCombinePublisher()
                .sink { _ in
    
                } receiveValue: { [weak self] returnedValue in
                    self?.title = returnedValue
                }
                .store(in: &cancellables)
        */
        
        /// - Using Escaping Closure
        /*
         getEscapingClosure { [weak self] returnedValue, error in
            self?.title = returnedValue
         }
        */

        
        /// - Using Future publisher
        getFuturePublisher()
        // doSomethingInFuture()
            .sink { completion in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)

    }
    
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in return "New Value"}
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completion: @escaping(_ returnedValue: String, _ error : Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion("New Value2", error)
        }
        .resume()
    }
        
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping(_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }
    
    func doSomethingInFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}


struct FuturesBootCamp: View {
    @State private var vm = FuturesViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesBootCamp()
}
