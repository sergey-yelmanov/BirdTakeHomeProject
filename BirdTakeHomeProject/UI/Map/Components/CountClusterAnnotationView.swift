//
//  CountClusterAnnotationView.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 18.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Cluster

final class CountClusterAnnotationView: ClusterAnnotationView {
    
    override func configure() {
        super.configure()

        guard let annotation = annotation as? ClusterAnnotation else { return }
        let count = annotation.annotations.count
        let diameter = radius(for: count) * 2
        frame.size = CGSize(width: diameter, height: diameter)
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .orange
        layer.borderWidth = 1.5
    }

    private func radius(for count: Int) -> CGFloat {
        if count < 5 {
            return 12
        } else if count < 10 {
            return 16
        } else {
            return 20
        }
    }
    
}
