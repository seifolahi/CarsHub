//
//  ManufactureViewModelTest.swift
//  CarsHubTests
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import XCTest
@testable import CarsHub
import Combine

class ManufactureViewModelTest: XCTestCase {
    
    var mockServiceLauncher: MockServiceLauncher!
    var sut: MultiPageListViewModel<ManufactureService>!
    
    private var bag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        mockServiceLauncher = MockServiceLauncher(baseURL: "http://somthing.com", token: "123")
        sut = MultiPageListViewModel(serviceLauncher: mockServiceLauncher, service: ManufactureService())
    }

    func testLoadFirstPage() throws {
        
        XCTAssertEqual(sut.itemsState.value, .idle)
        
        mockServiceLauncher.returningModel = generateNextPageTestData(page: 0,
                                                                      resultInPage:10,
                                                                      total: 43) as AnyObject
        var eventIndex = 0
        
        let stateExpectation = expectation(description: "stateEx")
        
        sut.itemsState.sink { comp in
            
        } receiveValue: { [weak self] state in
            
            if eventIndex == 0 {
                XCTAssertEqual(self?.sut.itemsState.value, .idle)
                XCTAssertEqual(self?.sut.items.count, 0)
            }
            
            if eventIndex == 1 {
                XCTAssertEqual(self?.sut.itemsState.value, .loading)
                XCTAssertEqual(self?.sut.items.count, 0)
            }
            
            if eventIndex == 2 {
                XCTAssertEqual(self?.sut.itemsState.value, .gotNewPage)
                XCTAssertEqual(self?.sut.items.count, 10)
                stateExpectation.fulfill()
            }
            
            eventIndex += 1
            
        }.store(in: &bag)
        
        sut.loadNextPage()
        wait(for: [stateExpectation], timeout: 1.0)
    }
    
    func testLoadLastPage() throws {
        
        XCTAssertEqual(sut.itemsState.value, .idle)
        
        mockServiceLauncher.returningModel = generateNextPageTestData(page: 0,
                                                                            resultInPage:10,
                                                                            total: 43) as AnyObject
        var eventIndex = 0
        var page = 0
        
        let stateExpectation = expectation(description: "stateEx")
        
        sut.itemsState.sink { comp in
            
        } receiveValue: { [weak self] state in
            
            if self?.sut.itemsState.value == .gotNewPage {
                self?.mockServiceLauncher.returningModel = self?.generateNextPageTestData(page: page,
                                                                                    resultInPage:10,
                                                                                    total: 43) as AnyObject
                if page == 3 {
                    self?.mockServiceLauncher.returningModel = self?.generateNextPageTestData(page: 5,
                                                                                        resultInPage:3,
                                                                                        total: 43) as AnyObject
                }
                
                self?.sut.loadNextPage()
                
                page += 1
            }
            
            if self?.sut.itemsState.value == .gotLastPage {
                
                XCTAssertEqual(self?.sut.items.count, 43)
                stateExpectation.fulfill()
            }
            
            eventIndex += 1
            
        }.store(in: &bag)
        
        sut.loadNextPage()
        wait(for: [stateExpectation], timeout: 1.0)
    }
    
    func generateNextPageTestData(page: Int, resultInPage: Int ,total: Int) -> MultiPageListModel {
        
        let pageSize = 10
        
        let keys = (0..<resultInPage).map { intNum in
            "\(intNum)"
        }
        
        let values = (0..<resultInPage).map { intNum in
            "car number \(intNum)"
        }
        
        let wkda = Dictionary(uniqueKeysWithValues: zip(keys, values))
        
        let model = MultiPageListModel(page: page,
                                       pageSize: pageSize,
                                       totalPageCount: Int(ceil(Double(total) / 10.0)),
                                       wkda: wkda)
        
        
        return model
    }
}
