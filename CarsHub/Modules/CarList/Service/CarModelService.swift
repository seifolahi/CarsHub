//
//  CarModelService.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation

struct CarModelService: ServiceRouter {
    
    var pagination: ServicePagination?
    var urlParams: [String : String]?
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "v1/car-types/main-types"
    }
    
    typealias ResponseType = MultiPageListModel
}
