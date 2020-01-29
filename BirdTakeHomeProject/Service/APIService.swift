//
//  APIService.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 29.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {

    func fetchData<T: Decodable>(
        class: T.Type,
        forResource resource: String,
        ofType type: String,
        completion: @escaping (Result<T, Error>) -> ()
    )

}

final class APIService: APIServiceProtocol {

    func fetchData<T: Decodable>(
        class: T.Type,
        forResource resource: String,
        ofType type: String = "json",
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else { return }

        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { data, _, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

        }.resume()
    }

}
