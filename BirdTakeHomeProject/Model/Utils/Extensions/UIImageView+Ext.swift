//
//  UIImageView+Ext.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 19.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(fromUrl urlString: String, withPlaceholer placeholder: UIImage?) {
        guard let url = URL(string: urlString) else {
            return
        }

        self.kf.indicatorType = .activity

        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.fade(0.5))]
        ) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Task failed: \(error.localizedDescription)")
            }
        }
    }

}
