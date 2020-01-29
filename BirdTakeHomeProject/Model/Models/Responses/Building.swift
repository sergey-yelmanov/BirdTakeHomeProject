//
//  Building.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

struct Building: Decodable {

    let id: Int
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let image: String

    var presentableName: String {
        name == "" ? "Empty name" : name
    }

    enum CodingKeys: String, CodingKey {
        case id = "building_id"
        case name
        case address
        case latitude
        case longitude
        case image = "image_url"
    }

}
