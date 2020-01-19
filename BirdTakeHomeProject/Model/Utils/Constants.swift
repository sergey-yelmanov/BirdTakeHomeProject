//
//  Constants.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 18.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

enum Constants {

    enum AnnotationReuseIdentifier {

        static let cluster = "cluster"
        static let pin = "pin"
        
    }

    enum Coordinates {

        static let kievLatitude = 50.45466
        static let kievLongitude = 30.5238
        
    }

    enum Device {

        static var isPhone: Bool {
            UIDevice.current.userInterfaceIdiom == .phone
        }

        static var isPad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }

    }

}
