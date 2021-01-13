//
//  DataModel.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 22.10.2020.
//

import Foundation
import SQLite

class BookEntity {
    
    static let shared = BookEntity()
    
    
    private let tblBooks = Table(K.Database.Table.Books)
    
    private let number = Expression<String>(K.Database.Row.Number)
    private let title = Expression<String>(K.Database.Row.Title)
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblBooks.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                    table.column(self.number)
                    table.column(self.title)
                }))
            } else {
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBooks() -> [Book]{
        var books = [Book]()
        do {
            if let booksTable = try Database.shared.connection?.prepare(BookEntity.shared.tblBooks) {
                
                for book in booksTable {
                    let book = Book(number: book[BookEntity.shared.number], title: book[BookEntity.shared.title])
                    books.append(book)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return books
    }
}
