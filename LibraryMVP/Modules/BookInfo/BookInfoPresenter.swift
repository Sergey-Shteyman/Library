//
//  BookInfoPresenter.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 24.03.2022.
//

import Foundation

// MARK: - BookInfoPresenterProtocol
protocol BookInfoPresenterProtocol: AnyObject {
    func fetchInfo()
}

// MARK: - BookInfoPresenter
final class BookInfoPresenter {
    
    weak var viewController: BookInfoViewProtocol?
    private let moduleBuilder: Buildable
    
    private let properties: Properties
    
    init(moduleBuilder: Buildable, properties: Properties) {
        self.moduleBuilder = moduleBuilder
        self.properties = properties
    }
    
}

// MARK: - BookInfoPresenterProtocol Impl
extension BookInfoPresenter: BookInfoPresenterProtocol {
    
    func fetchInfo() {
        viewController?.display(properties: properties)
    }
}
