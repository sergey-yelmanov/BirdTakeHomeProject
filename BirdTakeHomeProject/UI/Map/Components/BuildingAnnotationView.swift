//
//  BuildingAnnotationView.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Cluster

final class BuildingAnnotationView: StyledClusterAnnotationView {

    override func configure() {
        super.configure()

        frame.size = CGSize(width: 16, height: 16)
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .orange
        layer.borderWidth = 1.5
    }

}
