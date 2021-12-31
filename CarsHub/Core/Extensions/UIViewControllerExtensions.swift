//
//  UIViewControllerExtensions.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

extension UIViewController {

    func showSimpleAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
