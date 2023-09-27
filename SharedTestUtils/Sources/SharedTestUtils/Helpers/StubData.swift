//
//  StubData.swift
//  MoneyBoxTests
//
//  Created by Zeynep Kara on 17.01.2022.
//

import Foundation

public final class StubData {
    private init() {}
    public static func read<V: Decodable>(file: String, callback: @escaping (Result<V, Error>) -> Void) {
        if let path = Bundle.module.url(forResource: "\(file)", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let result = try JSONDecoder().decode(V.self, from: data)
                callback(.success(result))
            } catch {
                callback(.failure(NSError.error(with: "stub decoding error")))
            }
        } else {
            callback(.failure(NSError.error(with: "no json file")))
        }
    }
}
