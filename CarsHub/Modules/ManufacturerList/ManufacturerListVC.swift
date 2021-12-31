//
//  ManufacturerListVC.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

class ManufacturerListVC: UIViewController {
    
    var coordinator: ManufactureListCoordinator?
    var viewModel: ManufactureListViewModel!
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupTableView()
    }
    
    func setupVC() {
        title = "CarsHub©"
    }
    
    func setupTableView() {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ManufacturerListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToNextPage()
    }
}

extension ManufacturerListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? SimpleTableViewCell else { fatalError("Unsupported Cell")}
        
        let cellViewModel = viewModel.buildCellViewModel(for: indexPath.row)
        
        cell.fillCell(cellViewModel: cellViewModel)
        
        return cell
    }
}
