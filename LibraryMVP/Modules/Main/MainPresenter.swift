//
//  MainPresenter.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 23.03.2022.
//

import Foundation

// MARK: - MainPresenterProtocol
protocol MainPresenterProtocol: AnyObject {
    func fetchLibrary()
    func filterBooks(by text: String)
    func enabledFilter(_ isFiltering: Bool)
    func fetchBookInfoViewController(with indexPath: IndexPath)
}

// MARK: - MainPresenter
final class MainPresenter {
    
    private var books = [Book]()
    private var filteredBooks = [Book]()
    private var isFiltering = false
    
    weak var viewController: MainViewProtocol?
    
    private let fileReaderManager: FileReadable
    private let jsonDecoderManager: JSONDecodable
    private let moduleBuilder: Buildable
    
    init(fileReaderManager: FileReadable,
         jsonDecoderManager: JSONDecodable,
         moduleBuilder: Buildable) {
        self.fileReaderManager = fileReaderManager
        self.jsonDecoderManager = jsonDecoderManager
        self.moduleBuilder = moduleBuilder
    }
    
}

// MARK: - MainPresenterProtocol impl
extension MainPresenter: MainPresenterProtocol {


    func fetchLibrary() {
        let fileName = "libraryJson"
        let fileExtension = "json"
        guard let data = fileReaderManager.getDataFromFile(fileName: fileName,
                                                           fileExtansion: fileExtension) else {
            let title = "Что-то пошло не так"
            let message = "Не удалось прочитать файл \(fileName).\(fileExtension)"
            viewController?.showAllert(with: title, and: message)
            return
        }
        guard let library = jsonDecoderManager.decode(from: data, type: Library.self),
              let books = library.features else {
            return
        }
        self.books = books
        filteredBooks = books
        viewController?.display(books)
    }
    
    
    
    func filterBooks(by text: String) {
        filteredBooks = books.filter({ (book: Book) in
            return book.properties?.title?.lowercased().contains(text.lowercased()) ?? false
        })
        viewController?.display(filteredBooks)
    }
    
    func enabledFilter(_ isFiltering: Bool) {
        self.isFiltering = isFiltering
    }

    func fetchBookInfoViewController(with indexPath: IndexPath) {
        guard let property = getFiltredLibrary(with: indexPath) else {
            return
        }
        let bookInfoViewController = moduleBuilder.buildBookInfoModule(with: property)
        viewController?.routeTo(bookInfoViewController)
        
    }
}

// MARK: - Private methdos
private extension MainPresenter {
    
    func getFiltredLibrary(with indexPath: IndexPath) -> Properties? {
        var model: Properties?
        let row = indexPath.row
        
        if isFiltering {
                model = filteredBooks[row].properties
        } else {
                model = books[row].properties
        }
        return model
    }
}
