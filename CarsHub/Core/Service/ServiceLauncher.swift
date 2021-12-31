//
//  ServiceLauncher.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit
import Combine

protocol ServiceLauncherProtocol {
    
    func launch<T: ServiceRouter>(service: T) -> AnyPublisher<T.ResponseType, Error>
}

class ServiceLauncher: ServiceLauncherProtocol {
    
    let baseURL: String
    let token: String
    
    init(baseURL: String, token: String) {
        self.baseURL = baseURL
        self.token = token
    }
    
    func launch<T>(service: T) -> AnyPublisher<T.ResponseType, Error> where T : ServiceRouter {
        
        let req = service.buildRequest(withBase: baseURL, token: token)
        
        return URLSession
            .shared
            .dataTaskPublisher(for: req)
            .map(\.data)
            .decode(type: T.ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
