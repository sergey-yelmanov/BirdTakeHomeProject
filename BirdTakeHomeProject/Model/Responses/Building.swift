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

    enum CodingKeys: String, CodingKey {
        case id = "building_id"
        case name
        case address
        case latitude
        case longitude
        case image = "image_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.image = try container.decode(String.self, forKey: .image)
    }

}
