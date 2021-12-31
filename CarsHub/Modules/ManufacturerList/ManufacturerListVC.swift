//
//  ManufacturerListVC.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit
import Combine

class ManufacturerListVC: UIViewController {
    
    var coordinator: ManufactureListCoordinator?
    var viewModel: ManufactureListViewModel!
    
    private var tableView: UITableView!
    private var disposeBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupTableView()
        
        subscribe()
        
        viewModel.loadNextPage()
    }
    
    func setupVC() {
        title = "CarsHub©"
    }
    
    func setupTableView() {
        
        tableView = UITableView()
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.installFullSizeOn(parent: view)
    }
    
    func subscribe() {
        viewModel.itemsState.sink { completion in
        } receiveValue: { [weak self] state in
            switch state {
            case .idle:
                break
            case .gotLastPage:
                self?.tableView.showLoading(isLoading: false)
                self?.tableView.reloadData()
            case .gotNewPage:
                self?.tableView.showLoading(isLoading: false)
                self?.tableView.reloadData()
            case .loading:
                self?.tableView.showLoading(isLoading: true)
            case .error:
                self?.tableView.showLoading(isLoading: false)
                self?.showSimpleAlert(title: "Error", message: "Could not Load the page, try agin.")
            }
        }.store(in: &disposeBag)
    }
}

extension ManufacturerListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToNextPage()
    }
}

extension ManufacturerListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? SimpleTableViewCell else { fatalError("Unsupported Cell")}
        
        let cellViewModel = viewModel.buildCellViewModel(for: indexPath.row)
        
        cell.fillCell(cellViewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.items.count - 1 {
            viewModel.loadNextPage()
        }
    }
}
