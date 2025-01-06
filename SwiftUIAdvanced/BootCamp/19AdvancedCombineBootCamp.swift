//
//  AdvancedCombineBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 23/12/24.
//

import SwiftUI
import Combine

/**
 
 - There are two types of publisheres
     • Current value publisher - It will always have a value or an error
     • Passthrough value publisher - It might not have a value or an error in a given time
 
 */

/**
    - .`combineLatest` only works when every publisher emits a value at least once .
    - `.zip` only works for the same number of instances the publishers emit the value.
    - `.merge` only works for same type of publishers
 */

final class AdvancedCombineDataService {
    
     // @Published var basicPublisher: String = "First Publish"
    
    // let currValuePublisher = CurrentValueSubject<Int, Error>("First Publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                // self.basicPublisher = items[x]
                self.passThroughPublisher.send(items[x])
                
                if x > 4 && x < 8 {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                    self.boolPublisher.send(completion: .finished)
                }
            }
        }
    }
}


@Observable
final class AdvancedCombineViewModel {
    
    var dataArray: [String] = []
    var dataBools: [Bool] = []
    var error: String = ""
    
    @ObservationIgnored private let dataService: AdvancedCombineDataService
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    @ObservationIgnored private let multicastPublisher = PassthroughSubject<Int, Error>()
 
    init(_ dataService: AdvancedCombineDataService) {
        self.dataService = dataService
        addSubscribers()
    }
     
    private func addSubscribers() {
        
            /// - `Sequence` Operations
            /*
//            .first()
//            .first(where: { $0 > 4 })
//            .tryFirst(where: { value in
//                if value == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return value > 4
//            })
        
        
//            .last()
//            .last(where: { $0 > 4 })
        
//            .tryLast(where: { value in
//                if value == 13 {
//                    throw URLError(.serverCertificateHasBadDate)
//                }
//                return value > 1
//            })
        
//            .dropFirst()
//            .dropFirst(3)
//            .drop(while: { $0 < 6 })
//            .tryDrop(while: { value in
//                if value == 15 {
//                    throw URLError(.networkConnectionLost)
//                }
//                return  value < 6
//            })
        
//            .prefix(4)
//            .prefix(while: { $0 < 6 }) // for custom types
        
//            .output(at: 2)
//            .output(in: 2...7)
        
             */
        
        
            /// - `Mathematic` Operations
            /*
            // .max()
            // .max(by: >)
            // .tryMax(by: )
            
            // .min()
            // .min(by: >)
            // .tryMin(by: )
            */
        
        
            /// - `Filter / Reducing` Opertaions
            /*
            // .map{ String($0) }
        
        
             //.tryMap({ value in
             // if value == 5 {
             // throw URLError(.appTransportSecurityRequiresSecureConnection)
             // }
             // return String(value)
             // })
        
        
            // .compactMap({ value in
            //   if value == 5 {
            //       return nil
            //   }
            //   return String(value)
            // })
        
            // .tryCompactMap()
        
            // .filter({ $0 > 3 && $0 < 7 })
            // .tryFilter()
        
            // .removeDuplicates()
            // .removeDuplicates(by: { value1, value2 in
            //    return value1 == value2
            // })
            // .tryRemoveDuplicates(by: )
        
            // .replaceNil(with: 5)
            // .replaceEmpty(with: [])
            // .replaceError(with: "DEFAULT VALUE")
        
            // .scan(1, { existinValue, newValue in
            //  return existinValue * newValue
            // })
            // .scan(1, *)
            // .scan(0, +)
            // .tryScan(, )
            // .reduce(0, +)
            // .reduce(1, *)
            // .tryReduce(, )
            // .collect()
            // .collect(5)
            // .allSatisfy({ $0 <= 15 })
            // .tryAllSatisfy()
            */
        
        
            /// - `Timing` Operations
            /*
            // .debounce(for: 0.75, scheduler: DispatchQueue.main)
            // .delay(for: 2, scheduler: DispatchQueue.main)
            // .measureInterval(using: DispatchQueue.main)
            // .map { stride in
            //    return "\(stride.timeInterval)"
            // }
        
            // .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
            // .retry(3)
            // .timeout(0.75, scheduler: DispatchQueue.main)
            */
        
            /// - Multiple Publishers/Subscribers
            /*
            // .combineLatest(dataService.boolPublisher, dataService.intPublisher)
            // .compactMap { $1 ? String($0) : "n/a" }
            // .map { $1 ? String($0) : String($2)  }
        
            // .merge(with: dataService.intPublisher)
            // .zip(dataService.boolPublisher)
            // .map { tuple in
            //    if tuple.1 {
            //        return String(tuple.0)
            //    }
            //    return "n/a"
            // }
            // .map { $0.1 ? String($0.0) : "n/a" }
        
            // .zip(dataService.boolPublisher, dataService.intPublisher)
            // .map { tuple in
            //    return String(tuple.0) + tuple.1.description + String(tuple.2)
            // }
            
            // .tryMap { int in
                
            //   if int == 5 {
            //        throw URLError(.badURL)
            //    }
            //    return int
            // }
            // .catch { error in
            //    return self.dataService.intPublisher
            // }
            */
        
        
        let sharedPublisher = dataService.passThroughPublisher
            .share()
            .multicast(subject: multicastPublisher)
            // .multicast {
            //    PassthroughSubject<Int, Error>()
            // }
        
        sharedPublisher
            .map { String($0) }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error:: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] receivedValue in
                self?.dataArray.append(receivedValue)
            }
            .store(in: &cancellables)
        
        
        
        sharedPublisher
            .map { $0 % 2 == 0 }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error:: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] receivedValue in
                self?.dataBools.append(receivedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
}


struct AdvancedCombineBootCamp: View {
    
    @State private var vm = AdvancedCombineViewModel(.init())
    
    var body: some View {
        
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.dataArray, id: \.self) { datum in
                        Text(datum)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootCamp()
}
