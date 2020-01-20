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
        setupNavBarButtons()
    }

    private func setupNavBarButtons() {
        if Constants.Device.isPhone {
            let closeButton = UIBarButtonItem(
                barButtonSystemItem: .close,
                target: self,
                action: #selector(close)
            )

            navigationItem.rightBarButtonItem = closeButton
        }
    }

    // MARK: - Selectors

    @objc private func close() {
        dismiss(animated: true)
    }

    // MARK: - trait collections

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        navigationController?.setNavigationBarHidden(traitCollection.verticalSizeClass == .regular, animated: true)
    }

}
