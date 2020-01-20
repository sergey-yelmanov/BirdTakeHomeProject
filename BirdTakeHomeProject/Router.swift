//
//  Router.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class Router {

    // MARK: - Properties
    
    private var window: UIWindow!
    static var shared: Router!

    // MARK: - Initializers

    init(_ sceneWindow: UIWindow) {
        window = sceneWindow
        Router.shared = self
    }

    func showStartUpScreen() {
        window.rootViewController = MapViewController()
        window.makeKeyAndVisible()
    }

    // MARK: - Child routers

    lazy var buildingsDetails: BuildingDetailsRouter = { BuildingDetailsRouter(mainRouter: self) }()

}
