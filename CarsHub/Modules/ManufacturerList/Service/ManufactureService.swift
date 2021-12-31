//
//  ManufactureService.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation

class ManufactureService: ServiceRouter {
    static var method: HTTPMethod {
        return .get
    }
    
    static var path: String {
        return "v1/car-types/manufacturer"
    }
    
    typealias ResponseType = ManufactureServerModel
}
