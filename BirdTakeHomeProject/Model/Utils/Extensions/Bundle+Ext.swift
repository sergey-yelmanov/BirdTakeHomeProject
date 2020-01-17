//
//  Bundle+Ext.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

extension Bundle {

    func decode<T: Decodable>(_ type: T.Type, from fileName: String) -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError()
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(type, from: data) else {
            fatalError()
        }

        return loaded
    }
}
