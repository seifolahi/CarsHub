//
//  BaseViewModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

class BaseViewModel {
    
    let serviceLauncher: ServiceLauncherProtocol
    
    init(serviceLauncher: ServiceLauncherProtocol) {
        self.serviceLauncher = serviceLauncher
    }
}
