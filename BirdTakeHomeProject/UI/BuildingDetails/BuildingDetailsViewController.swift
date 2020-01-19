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
        subscribeForNotifications()
    }

    deinit {
       NotificationCenter.default.removeObserver(self)
    }

    // MARK: - UI Configuration

    private func configureUI() {
        view = BuildingDetailsView(building: building)

        if Constants.Device.isPhone {
            let closeButton = UIBarButtonItem(
                barButtonSystemItem: .close,
                target: self,
                action: #selector(close)
            )

            navigationItem.leftBarButtonItem = closeButton
        }
    }

    // MARK: - Notifications

    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(rotated),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    // MARK: - Selectors

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func rotated() {
        guard let buildingDetailsView = view as? BuildingDetailsView else { return }

        buildingDetailsView.applyConstraintsForPhone()
    }

}
