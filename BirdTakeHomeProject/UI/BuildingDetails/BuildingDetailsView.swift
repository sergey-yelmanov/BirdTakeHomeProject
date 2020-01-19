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
    private var gradientLayer: CAGradientLayer!

    private var imageViewPortraitConstraintForPhone = [NSLayoutConstraint]()
    private var imageViewLandscapeConstraintForPhone = [NSLayoutConstraint]()

    private var nameLabelPortraitConstraintForPhone = [NSLayoutConstraint]()
    private var nameLabelLandscapeConstraintForPhone = [NSLayoutConstraint]()

    private lazy var dimmedView: UIView = {
        let view = UIView()

        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false

        imageView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            view.heightAnchor.constraint(equalToConstant: 44)
        ])

        return view
    }()

    // MARK: - Initializers
    
    init(building: Building) {
        self.building = building
        super.init(frame: .zero)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if Constants.Device.isPad {
            createGradientLayer()
        }
    }

    // MARK: - UI Configuration

    private func configureUI() {
        backgroundColor = .white
        configureImageView()
        configureNameLabel()
        configureConstaraints()
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
        imageView.backgroundColor = .lightGray

        addSubview(imageView)

        if Constants.Device.isPhone {
            configureImageViewForPhone()
        }

        imageView.loadImage(fromUrl: building.image, withPlaceholer: nil)
    }

    private func configureImageViewForPhone() {
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Name label configurations

    private func configureNameLabel() {
        Constants.Device.isPhone ? configureNameLabelForPhone() : configureNameLabelForPad()
    }

    private func configureNameLabelForPhone() {
        nameLabel.text = building.presentableName
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameLabel)
    }

    private func configureNameLabelForPad() {
        nameLabel.text = building.presentableName
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameLabel)
    }

    // MARK: - Constraints configuration

    private func configureConstaraints() {
        applyConstraintsForPhone()
        applyConstaintsForPad()
    }

    func applyConstraintsForPhone() {
        guard Constants.Device.isPhone else { return }

        if Constants.Device.isLandscape {
            applyNameLabelLandscapeConstaintsForPhone()
            applyImageViewLandscapeConstaintsForPhone()
        } else {
            applyNameLabelPortraitConstaintsForPhone()
            applyImageViewPortraitConstaintsForPhone()
        }
    }

    private func applyConstaintsForPad() {
        guard Constants.Device.isPad else { return }

        imageView.pin(to: self)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor)
        ])
    }

    private func applyImageViewPortraitConstaintsForPhone() {
        NSLayoutConstraint.deactivate(imageViewLandscapeConstraintForPhone)

        imageViewPortraitConstraintForPhone = [
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.aspectRation(3/4)
        ]

        NSLayoutConstraint.activate(imageViewPortraitConstraintForPhone)
    }

    private func applyImageViewLandscapeConstaintsForPhone() {
        NSLayoutConstraint.deactivate(imageViewPortraitConstraintForPhone)

        imageViewLandscapeConstraintForPhone = [
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            imageView.aspectRation(3/4)
        ]

        NSLayoutConstraint.activate(imageViewLandscapeConstraintForPhone)
    }

    private func applyNameLabelPortraitConstaintsForPhone() {
        NSLayoutConstraint.deactivate(nameLabelLandscapeConstraintForPhone)

        nameLabelPortraitConstraintForPhone = [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]

        NSLayoutConstraint.activate(nameLabelPortraitConstraintForPhone)
    }

    private func applyNameLabelLandscapeConstaintsForPhone() {
        NSLayoutConstraint.deactivate(nameLabelPortraitConstraintForPhone)

        nameLabelLandscapeConstraintForPhone = [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ]

        NSLayoutConstraint.activate(nameLabelLandscapeConstraintForPhone)
    }
    
}
