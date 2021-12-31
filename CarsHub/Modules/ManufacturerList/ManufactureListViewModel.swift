//
//  ManufactureListViewModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation

struct ManufactureListViewModel {
    
    var itemsDict: [String: String] {
        get {
            return ["Car A": "101", "Car B": "102", "Car C": "103"]
        }
    }
    
    var itemsTitle: [String] {
        get {
            return itemsDict.keys.sorted()
        }
    }
    
    func buildCellViewModel(for index: Int) -> SimpleTableViewCellViewModel {
        let rowTitle = itemsTitle[index]
        return SimpleTableViewCellViewModel(index: index, title: rowTitle)
    }
    
    func loadFromServer() {
        
    }
}
