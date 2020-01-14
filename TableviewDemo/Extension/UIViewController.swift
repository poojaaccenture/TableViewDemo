//
//  UIViewController.swift
//  TableviewDemo
//
//  Created by Pooja Gupta on 14/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(with title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
