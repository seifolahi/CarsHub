//
//  ServiceRouterTests.swift
//  CarsHubTests
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import XCTest
@testable import CarsHub

class ServiceRouterTests: XCTestCase {

    func testRouterURLMakeing() throws {
        
        let baseUrl = "http://somthing.com/"
        let token = "123"
        
        let sut = ManufactureService(pagination: nil, urlParams: nil)
        let req = sut.buildRequest(withBase: baseUrl, token: token)
        
        let correctOutput = "http://somthing.com/v1/car-types/manufacturer?wa_key=123"
        
        XCTAssertEqual(req.url?.absoluteString ?? "", correctOutput)
    }
    
    func testRouterURLMakeingWithParams() throws {
        
        let baseUrl = "http://somthing.com/"
        let token = "123"
        
        let sut = ManufactureService(pagination: ServicePagination(pageSize: 12, page: 8), urlParams: ["a": "b"])
        let req = sut.buildRequest(withBase: baseUrl, token: token)
        
        let paramsPart = (req.url?.absoluteString ?? "").split(separator: "?")[1]
        let params = paramsPart.split(separator: "&")
        
        XCTAssertTrue(params.contains("wa_key=123"))
        XCTAssertTrue(params.contains("page=8"))
        XCTAssertTrue(params.contains("pageSize=12"))
        XCTAssertTrue(params.contains("a=b"))
        
        XCTAssertEqual(params.count, 4)
    }
}

