//
//  SimpleTableViewCellViewModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation

struct SimpleTableViewCellViewModel {
    
    var index: Int
    var title: String
    
    var isEven: Bool {
        get {
            (index % 2 == 0)
        }
    }
}
