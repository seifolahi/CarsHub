//
//  RootCoordinator.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var window: UIWindow?
    var navigationController: UINavigationController
    
    init(window: UIWindow) {
        
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let manufactureListCoordinator = ManufactureListCoordinator(navigation: navigationController)
        manufactureListCoordinator.start()
    }
}
