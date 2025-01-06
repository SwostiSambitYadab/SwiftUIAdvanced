//
//  UnitTestingViewModel_Tests.swift
//  SwiftUIAdvancedTests
//
//  Created by hb on 23/12/24.
//

import XCTest
@testable import SwiftUIAdvanced

// Naming structure: test_unitOfWork_StateUnderText_ExpectedBehaviour

// NamingStructure: test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When , Then

final class UnitTestingViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?

    override func setUpWithError() throws {
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UniTestingViewModel_isPremium_shouldBeTrue() {
        
        // Given
        let userIsPremium: Bool = true
        
        // when
        let vm   = UnitTestingViewModel(isPremium: userIsPremium)
        
        // then
        XCTAssertTrue(vm.isPremium)
    }
    
    
    func test_UniTestingViewModel_isPremium_shouldBeFalse() {
        
        // Given
        let userIsPremium: Bool = false
        
        // when
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // then
        XCTAssertFalse(vm.isPremium)
    }
    
    
    func test_UniTestingViewModel_isPremium_shouldBeInjectedValue() {
        
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // when
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    
    func test_UniTestingViewModel_isPremium_shouldBeInjectedValue_stress() {
        
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // when
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            // then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    
    func test_unitTestingViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_unitTestingViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_unitTestingViewModel_dataArray_shouldNotAddBlankItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    
    func test_unitTestingViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    
    func test_unitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        // select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // select invalid item
        vm.selectItem(item: UUID().uuidString)

        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    
    func test_unitTestingViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)

        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    
    func test_unitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        var items: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            vm.selectItem(item: newItem)
            items.append(newItem)
        }
        
        let randomItem = items.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        XCTAssertFalse(randomItem.isEmpty)

        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_unitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }

        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw not found error!") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
        }
    }
    
    
    func test_unitTestingViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }

        // Then
        
        do {
            try vm.saveItem(item: "")
        } catch {
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
    }
    
    
    func test_unitTestingViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        
        var items: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            items.append(newItem)
        }
        
        let randomItem = items.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
    }
}
