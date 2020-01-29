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
    private var showAllAnnotationsButton: UIButton!

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()

        configureUI()
        fetchData()
    }

    // MARK: - UI Configuration

    private func configureUI() {
        view.backgroundColor = .white
        view = MapView(showDetailsAction: showDetails)
        configureShowAllAnnotationsButton()
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

    private func configureShowAllAnnotationsButton() {
        showAllAnnotationsButton = UIButton()
        showAllAnnotationsButton.addTarget(
            self,
            action: #selector(showAllAnnotationsButtonTapped),
            for: .touchUpInside
        )
        showAllAnnotationsButton.setImage(
            UIImage(
                systemName: "arrow.uturn.up.circle",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.06)),
            for: .normal
        )
        showAllAnnotationsButton.tintColor = Constants.Colors.customTextColor
        showAllAnnotationsButton.layer.cornerRadius = 4
        showAllAnnotationsButton.layer.masksToBounds = true

        showAllAnnotationsButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(showAllAnnotationsButton)

        NSLayoutConstraint.activate([
            showAllAnnotationsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            showAllAnnotationsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            showAllAnnotationsButton.widthAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.09),
            showAllAnnotationsButton.aspectRation(1)
        ])

        configureBlurEffectViewForhowAllAnnotationsButton()
    }

    private func configureBlurEffectViewForhowAllAnnotationsButton() {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        showAllAnnotationsButton.insertSubview(blurEffectView, at: 0)
        
        if let imageView = showAllAnnotationsButton.imageView{
            showAllAnnotationsButton.bringSubviewToFront(imageView)
        }

        NSLayoutConstraint.activate([
            blurEffectView.centerXAnchor.constraint(equalTo: showAllAnnotationsButton.centerXAnchor),
            blurEffectView.centerYAnchor.constraint(equalTo: showAllAnnotationsButton.centerYAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: showAllAnnotationsButton.widthAnchor),
            blurEffectView.aspectRation(1)
        ])
    }

    // MARK: - Networking

    private func fetchData() {
        APIService().fetchData(class: [Building].self, forResource: "buildings") { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let buildings = self.removeZeroLocationItems(from: response)
                guard let mapView = self.view as? MapView else { return }
                mapView.configure(withBuildings: buildings)
            case .failure(let error):
                AlertService.showAlert(
                    vc: self,
                    title: "Error",
                    message: error.localizedDescription
                )
            }
        }
    }

    // MARK: - Actions

    private func showDetails(withBuilding building: Building) {
        Router.shared.buildingsDetails.showBuildingDetails(fromParent: self, building: building)
    }

    @objc private func showAllAnnotationsButtonTapped() {
        guard let mapView = view as? MapView else { return }

        mapView.showAllAnnotations()
    }

    // MARK: - Helpers

    private func removeZeroLocationItems(from buildings: [Building]) -> [Building] {
        buildings.filter { $0.longitude != 0}
    }

}
