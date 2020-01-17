//
//  Router.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

class Router {

    private var window: UIWindow!
    static var instance: Router!

    // MARK: - Inits

    init(_ sceneWindow: UIWindow) {
        window = sceneWindow
        Router.instance = self
    }

    func start() {
        window.rootViewController = MapViewController()
        window.makeKeyAndVisible()
    }

}
