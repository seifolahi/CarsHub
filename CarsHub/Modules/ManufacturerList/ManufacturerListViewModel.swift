//
//  ManufacturerListViewModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 1/1/22.
//

import UIKit

class ManufacturerListViewModel: MultiPageListViewModel<ManufactureService> {

    func findKeyFor(index: Int) -> String? {
        
        let value = items[index]
        
        if let key = itemsDict.first(where: { $0.value == value })?.key {
            return key
        }
        
        return nil
    }
}
