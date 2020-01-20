//
//  BuildingDetailsView.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 19.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class BuildingDetailsView: UIView {

    // MARK: - Private Properties

    private var building: Building!

    // MARK: - UI components

    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    private var dimmedView: UIView!
    private var gradientLayer: CAGradientLayer!

    // MARK: - Constraints

    private var regularConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()

    // MARK: - Initializers
    
    init(building: Building) {
        self.building = building
        super.init(frame: .zero)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Configuration

    private func configureUI() {
        backgroundColor = .systemBackground
        configureNameLabel()
        configureImageView()

        delay(0.01) {
            if Constants.Device.isPad {
                self.createGradientLayer()
            }
        }

        activateCurrentConstraints()
    }

    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()

        gradientLayer.frame = dimmedView.bounds

        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]

        dimmedView.layer.addSublayer(gradientLayer)
    }

    // MARK: - Image view configurations

    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8316857219, green: 0.831825912, blue: 0.8316672444, alpha: 1)

        addSubview(imageView)

        Constants.Device.isPhone ? configureImageViewForPhone() : configureImageViewForPad()

        imageView.loadImage(fromUrl: building.image, withPlaceholer: UIImage(named: "icon"))
    }

    private func configureImageViewForPhone() {
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false

        compactConstraints.append(contentsOf: [
            imageView.widthAnchor.constraint(equalToConstant: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            imageView.aspectRation(3/4)
        ])

        regularConstraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.aspectRation(3/4)
        ])
    }

    private func configureImageViewForPad() {
        imageView.pin(to: self)
    }

    // MARK: - Name label configurations

    private func configureNameLabel() {
        nameLabel.textAlignment = .center
        Constants.Device.isPhone ? configureNameLabelForPhone() : configureNameLabelForPad()
    }

    private func configureNameLabelForPhone() {
        nameLabel.text = building.presentableName
        nameLabel.textColor = Constants.Colors.customTextColor
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameLabel)

        compactConstraints.append(contentsOf: [
            nameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        regularConstraints.append(contentsOf: [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func configureNameLabelForPad() {
        configureDimmedView()

        nameLabel.text = building.presentableName
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: dimmedView.trailingAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: dimmedView.leadingAnchor, constant: 8)
        ])
    }

    private func configureDimmedView() {
        dimmedView = UIView()
        dimmedView.alpha = 0.3
        dimmedView.translatesAutoresizingMaskIntoConstraints = false

        imageView.addSubview(dimmedView)

        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0),
            dimmedView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            dimmedView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            dimmedView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Helpers

    private func activateCurrentConstraints() {
        if Constants.Device.isPhone {
            NSLayoutConstraint.deactivate(compactConstraints + regularConstraints)

            if traitCollection.verticalSizeClass == .regular {
                NSLayoutConstraint.activate(regularConstraints)
            } else {
                NSLayoutConstraint.activate(compactConstraints)
            }
        }
    }

    // MARK: - Trait collections

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        activateCurrentConstraints()
    }
    
}
