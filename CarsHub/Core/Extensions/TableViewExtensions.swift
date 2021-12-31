//
//  TableViewExtensions.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

extension UITableView {
    
    func showLoading(isLoading: Bool) {
        if isLoading {
            let indicator = UIActivityIndicatorView()
            indicator.style = .large
            indicator.startAnimating()
            tableFooterView = indicator
        } else {
            if tableFooterView is UIActivityIndicatorView {
                tableFooterView = nil
            }
        }
    }
}
