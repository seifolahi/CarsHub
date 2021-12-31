//
//  CarModelCoordinator.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit


struct CarModelCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var manufacturerID: String
    var manufacturerName: String
    
    init(navigation: UINavigationController, manufacturerID: String, manufacturerName: String) {
        self.navigationController = navigation
        self.manufacturerID = manufacturerID
        self.manufacturerName = manufacturerName
    }
    
    func start() {
        let carModelVC = CarModelVC()
        carModelVC.coordinator = self
        carModelVC.selectedManufacturer = manufacturerName
        var service = CarModelService()
        service.urlParams = ["manufacturer": manufacturerID]
        carModelVC.viewModel = CarModelViewModel(
            serviceLauncher: Dependencies.networkServiceLauncher,
            service: service)
        navigationController.pushViewController(carModelVC, animated: true)
    }
}
