//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit


enum NetworkError: Error {
    case invalidUrl
    case invalidQuery
    case decodingFailure
}
protocol NetworkContract {
    func request<T: Decodable>(url: String, modelType: T.Type)async throws -> T
}

class Network { }

extension Network: NetworkContract {
    func request<T>(url: String, modelType: T.Type) async throws -> T where T : Decodable {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode(modelType.self, from: data)
        } catch let error as NSError {
            print("JSON decode failed: \(error.localizedDescription)")
            throw NetworkError.decodingFailure
        }
    }
}
