//
//  DataModel.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 22.10.2020.
//

import Foundation
import SQLite

class Books {
    
    static let shared = Books()
    
    
    let books = Table("books")
    
    let number = Expression<String>("number")
    let title = Expression<String>("title")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(books.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
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
    

}


//
//struct Chapters {
//    let chapters = Table("chapters")
//    let number = Expression<String>("number")
//    let title = Expression<String>("title")
//    let bookNumber = Expression<String>("book_number")
//}
//
//struct Articles {
//    let articles = Table("articles_content")
//    let articleId = Expression<Int>("docid")
//    let number = Expression<String>("c0number")
//    let title = Expression<String>("c1title")
//    let content = Expression<String>("c2content")
//    let favourite = Expression<Int>("c3favourite")
//    let chapterNumber = Expression<String>("c4chapter_number")
//}
