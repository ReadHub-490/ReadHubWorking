//
//  ViewController+Extensions.swift
//  ReadHub
//
//  Created by Chinmay Bansal on 3/29/23.
//

import UIKit

extension UIViewController {

    /// Shows an alert with the given description or default text if nil.
    func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Unknown error")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
