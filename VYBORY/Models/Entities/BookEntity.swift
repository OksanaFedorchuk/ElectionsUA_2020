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
    
    
    private let tblBooks = Table("books")
    
    private let number = Expression<String>("number")
    private let title = Expression<String>("title")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblBooks.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                    table.column(self.number)
                    table.column(self.title)
                }))
                print ("Table Books has been created")
            } else {
                print ("Fail creating the table Books")
            }
        } catch {
            let nserror = error as NSError
            print("Fail creating the table Books. Error: \(nserror)")
        }
    }
    
    func getBooks() -> [[String]]{
        var books = [[String]]()
        do {
            if let booksTable = try Database.shared.connection?.prepare(BookEntity.shared.tblBooks) {
                
                for book in booksTable {
                    let number = book[BookEntity.shared.number]
                    let title = book[BookEntity.shared.title]
                    books.append([number, title])
                }
            }
        } catch {
            print(error)
        }
        return books
    }
}
