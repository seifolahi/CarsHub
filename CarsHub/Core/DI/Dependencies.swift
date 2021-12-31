//
//  Dependencies.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

class Dependencies {
    
    static var networkServiceLauncher: ServiceLauncherProtocol {
        let baseURL = "http://api-aws-eu-qa-1.auto1-test.com/"
        let token = "coding-puzzle-client-449cc9d"
        return ServiceLauncher(baseURL: baseURL, token: token)
    }
}
