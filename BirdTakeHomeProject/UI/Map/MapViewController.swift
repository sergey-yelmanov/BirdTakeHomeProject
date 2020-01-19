//
//  MapViewController.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class MapViewController: UIViewController {

    // MARK: - Private properties

    private var blurEffectView: UIVisualEffectView!

    private var buildings = Bundle.main.decode([Building].self, from: "buildings.json")

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()

        configureUI()
    }

    // MARK: - UI Configuration

    private func configureUI() {
        view.backgroundColor = .white
        view = MapView(buildings: buildings, showDetailsAction: showDetails)
        configureBlurEffectView()
    }

    private func configureBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    // MARK: - Actions

    private func showDetails(withBuilding building: Building) {
        Router.shared.buildingsDetails.showBuildingDetails(fromParent: self, building: building)
    }

}
