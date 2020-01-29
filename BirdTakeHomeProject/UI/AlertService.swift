//
//  AlertService.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 29.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

struct AlertService {

    static func showAlert(vc: UIViewController, title: String?, message: String?, completionHandler:(()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = .orange

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler?()
        }

        alert.addAction(okAction)

        vc.present(alert, animated: true)
    }
    
}
