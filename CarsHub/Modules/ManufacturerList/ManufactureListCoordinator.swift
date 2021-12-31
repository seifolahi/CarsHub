//
//  ManufactureListCoordinator.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit


struct ManufactureListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let manufacturerListVC = ManufacturerListVC()
        manufacturerListVC.coordinator = self
        navigationController.pushViewController(manufacturerListVC, animated: false)
    }
    
    func goToNextPage() {
        
    }
}
