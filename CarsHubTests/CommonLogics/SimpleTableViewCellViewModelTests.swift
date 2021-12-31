//
//  SimpleTableViewCellViewModelTests.swift
//  CarsHubTests
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import XCTest
@testable import CarsHub

class SimpleTableViewCellViewModelTests: XCTestCase {
    
    var sut: SimpleTableViewCellViewModel!

    func testIsOdd() throws {
        sut = SimpleTableViewCellViewModel(index: 0, title: "")
        XCTAssertTrue(sut.isEven)
        
        sut = SimpleTableViewCellViewModel(index: 1, title: "")
        XCTAssertFalse(sut.isEven)
        
        sut = SimpleTableViewCellViewModel(index: 323, title: "")
        XCTAssertFalse(sut.isEven)
    }
}
