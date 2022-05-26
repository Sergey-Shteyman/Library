//
//  Model.swift
//  LibraryMVP
//
//  Created by Сергей Штейман on 14.02.2022.
//

import Foundation

// MARK: - Library
public struct Library: Decodable {
    let features: [Book]?
}

// MARK: - Book
public struct Book: Decodable {
    let type: String?
    let properties: Properties?
    let geometry: String?
}

// MARK: - BookType
enum BookType: String, Decodable {
    case audio = "Аудиокнига"
    case electron = "Электронный текст"
    case pdf = "PDF-книга"
    
    var imageName: String {
        switch self {
        case .audio:
            return "audioBook"
        case .electron:
            return "book"
        case .pdf:
            return "book"
        }
    }
}

// MARK: - Properties
public struct Properties: Decodable {
    
    let id: Int?
    let title: String?
    let type: BookType // "Аудиокнига"  "Электронный текст"
    let autor: String?
    let autorFulName: String?
    let age: Int?     // 0 6 12 16 18
    let recipeData: String?
    let recipePrice: Double?
    let issuesCount: Int?
    let numberBook: Int?
    let issueBefore: String?
    let genre: String?

    enum CodingKeys: String, CodingKey {
        
        case id = "ID"
        case title = "Название"
        case type = "Тип"
        case autor = "Автор"
        case autorFulName = "Автор (ФИО)"
        case age = "Возрастное ограничение на книгу"
        case recipeData = "Дата поступления"
        case recipePrice = "Цена поступления"
        case issuesCount = "Кол-во выдач"
        case numberBook = "Инвентарный номер"
        case issueBefore = "Выдана до"
        case genre = "Жанр книги"
        
    }
    
}

