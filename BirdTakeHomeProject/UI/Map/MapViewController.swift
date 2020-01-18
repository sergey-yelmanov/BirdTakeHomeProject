//
//  MapViewController.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class MapViewController: UIViewController {

    private var buildings = Bundle.main.decode([Building].self, from: "buildings.json")

    override func loadView() {
        super.loadView()

        view = MapView(buildings: buildings)
    }

}
