//
//  Database.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 22.10.2020.
//

import Foundation
import SQLite

class Database {
    static let shared = Database()
    public let connection: Connection?

    init(){
        do {
            let path = Bundle.main.path(forResource: "code", ofType: "db")!
            connection = try Connection(path)
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    func countBooks() -> Int {
        var count = 0
        do {
            if let books = try connection?.prepare(Books.shared.books) {
                
                for book in books {
                    count += 1
                    print("number: \(book[Books.shared.number]), title: \(book[Books.shared.title])")
                }
            }
        } catch {
            print(error)
        }
        return count
    }
     
    func getBooks() -> [String]{
        var bookArray = Array<String>()
        do {
            if let books = try connection?.prepare(Books.shared.books) {
                
                for book in books {
                    let number = book[Books.shared.number]
                    bookArray.append(number)
                    print("number: \(book[Books.shared.number]), title: \(book[Books.shared.title])")
                }
            }
        } catch {
            print(error)
        }
        return bookArray
    }
}
