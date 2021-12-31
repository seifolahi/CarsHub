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
        manufacturerListVC.viewModel = ManufacturerListViewModel(
            serviceLauncher: Dependencies.networkServiceLauncher,
            service: ManufactureService())
        navigationController.pushViewController(manufacturerListVC, animated: true)
    }
    
    func goToNextPage(manufacturerID: String, manufacturerName: String) {
        let coordinator = CarModelCoordinator(navigation: navigationController,
                                              manufacturerID: manufacturerID,
                                              manufacturerName: manufacturerName)
        coordinator.start()
    }
}
