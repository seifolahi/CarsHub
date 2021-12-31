//
//  MultiPageListViewModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation
import Combine

enum ListState {
    case idle, loading, error, gotNewPage, gotLastPage
}

class MultiPageListViewModel<T: ServiceRouter>: BaseViewModel {
    
    let itemsState = CurrentValueSubject<ListState, Error>(.idle)
    var items: [String] = []
    
    private var disposeBag = Set<AnyCancellable>()
    
    private var lastLoadedPage: Int = -1
    private var pageSize = 10
    
    var itemsDict: [String: String] = [:]
    
    private var service: T!
    
    init(serviceLauncher: ServiceLauncherProtocol, service: T) {
        super.init(serviceLauncher: serviceLauncher)
        self.service = service
    }
    
    func buildCellViewModel(for index: Int) -> SimpleTableViewCellViewModel {
        let rowTitle = items[index]
        return SimpleTableViewCellViewModel(index: index, title: rowTitle)
    }
    
    func loadNextPage() {
        
        if itemsState.value == .loading || itemsState.value == .gotLastPage {
            return
        }
        
        service.pagination = ServicePagination(pageSize: pageSize, page: lastLoadedPage + 1)
        
        itemsState.send(.loading)
        
        serviceLauncher
            .launch(service: service)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.itemsState.send(.error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] model in
                self?.updateData(model: model)
            }.store(in: &disposeBag)

    }
    
    private func updateData(model: T.ResponseType) {
        
        guard let model = model as? MultiPageListModel else { return }
        
        lastLoadedPage = model.page
        itemsDict.merge(model.wkda) { (_, new) in new }
        
        items.append(contentsOf: model.wkda.values)
        
        if model.page == model.totalPageCount {
            itemsState.send(.gotLastPage)
        } else {
            itemsState.send(.gotNewPage)
        }
    }
}
