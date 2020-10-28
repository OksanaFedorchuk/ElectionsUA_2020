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
    
    func getBooks() -> [String]{
        var bookArray = Array<String>()
        do {
            if let books = try Database.shared.connection?.prepare(BookEntity.shared.tblBooks) {
                
                for book in books {
                    let number = book[BookEntity.shared.number]
                    bookArray.append(number)
                }
            }
        } catch {
            print(error)
        }
        return bookArray
    }
    
    func getTitles() -> [String]{
        var bookArray = Array<String>()
        do {
            if let books = try Database.shared.connection?.prepare(BookEntity.shared.tblBooks) {
                
                for book in books {
                    let title = book[BookEntity.shared.title]
                    bookArray.append(title)
                }
            }
        } catch {
            print(error)
        }
        return bookArray
    }
}
