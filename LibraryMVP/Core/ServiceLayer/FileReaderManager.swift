//
//  FileReaderManager.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 16.02.2022.
//

import Foundation

// MARK: FileReadable
protocol FileReadable {
    func getDataFromFile(fileName: String, fileExtansion: String) -> Data?
}

// MARK: - FileReaderManager
final class FileReaderManager {
    
}

// MARK: - FileReadable Impl
extension FileReaderManager: FileReadable {
    
    func getDataFromFile(fileName: String, fileExtansion: String) -> Data?  {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtansion) else {
            print("Could not get data from file")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
