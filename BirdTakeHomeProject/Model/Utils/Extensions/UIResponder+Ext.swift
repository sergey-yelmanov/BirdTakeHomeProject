//
//  UIResponder+Ext.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 20.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIResponder {

    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }

}
