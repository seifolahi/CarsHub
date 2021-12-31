//
//  MockServiceLauncher.swift
//  CarsHubTests
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation
@testable import CarsHub
import Combine

class MockServiceLauncher: ServiceLauncherProtocol {
    
    let baseURL: String
    let token: String
    
    var returningModel: AnyObject?
    
    init(baseURL: String, token: String) {
        self.baseURL = baseURL
        self.token = token
    }
    
    func launch<T>(service: T) -> AnyPublisher<T.ResponseType, Error> where T : ServiceRouter {
        return CurrentValueSubject<T.ResponseType, Error>(returningModel as! T.ResponseType)
            .eraseToAnyPublisher()
            
    }
}
