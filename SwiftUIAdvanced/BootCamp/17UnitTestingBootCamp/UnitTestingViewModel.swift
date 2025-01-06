//
//  UnitTestingViewModel.swift
//  SwiftUIAdvanced
//
//  Created by hb on 23/12/24.
//

import Foundation
import SwiftUI

@Observable
class UnitTestingViewModel {
    var isPremium: Bool
    var dataArray: [String] = []
    var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
            debugPrint("Saved item here !!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
}

