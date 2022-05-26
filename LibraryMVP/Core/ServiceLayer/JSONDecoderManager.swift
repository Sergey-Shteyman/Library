//
//  JSONDecoderManager.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 16.02.2022.
//

import Foundation

// MARK: JSONDecodable
protocol JSONDecodable {
    func decode<T: Decodable>(from data: Data, type: T.Type) -> T?
}

// MARK: - JSONDecoderManager
final class JSONDecoderManager{
    private let decoder = JSONDecoder()
}

// MARK: - JSONDecodable Impl
extension JSONDecoderManager: JSONDecodable {
    
    func decode<T: Decodable>(from data: Data, type: T.Type) -> T? {
        do {
            let result = try decoder.decode(type, from: data)
            return result
        } catch {
            print("Error \(error)")
            return nil
        }
        
        
    }
}
