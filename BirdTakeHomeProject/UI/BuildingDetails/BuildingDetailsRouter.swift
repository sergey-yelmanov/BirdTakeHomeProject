//
//  BuildingDetailsRouter.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 19.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class BuildingDetailsRouter {

    private weak var mainRouter: Router!

    init(mainRouter: Router) {
        self.mainRouter = mainRouter
    }

    func showBuildingDetails(fromParent parent: UIViewController, building: Building) {
        let vc = BuildingDetailsViewController()
        
        vc.building = building

        parent.present(vc, animated: true)
    }
    
}
