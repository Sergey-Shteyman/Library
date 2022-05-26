//
//  ModuleBuilder.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 24.03.2022.
//

import Foundation

// MARK: - Buildable
protocol Buildable {
    func buildMainModule() -> MainViewController
    func buildBookInfoModule(with properties : Properties) -> BookInfoViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
    private let fileReaderManager: FileReadable
    private let jsonDecoderManager: JSONDecodable
    
    init() {
        fileReaderManager = FileReaderManager()
        jsonDecoderManager = JSONDecoderManager()
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildMainModule() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(fileReaderManager: fileReaderManager,
                                      jsonDecoderManager: jsonDecoderManager,
                                      moduleBuilder: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildBookInfoModule(with properties: Properties) -> BookInfoViewController {
        let viewController = BookInfoViewController()
        let presenter = BookInfoPresenter(moduleBuilder: self, properties: properties)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
