//
//  BuildingDetailsViewController.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 19.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class BuildingDetailsViewController: UIViewController {

    // MARK: - Properties

    var building: Building!

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()

        configureUI()
    }

    // MARK: - UI Configuration

    private func configureUI() {
        view = BuildingDetailsView(building: building)
    }

    // MARK: - Selectors

    @objc private func close() {
        dismiss(animated: true)
    }

}
