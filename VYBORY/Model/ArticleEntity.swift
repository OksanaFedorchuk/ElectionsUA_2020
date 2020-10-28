//
//  ArticleEntity.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 28.10.2020.
//

import Foundation
import SQLite

class ArticleEntity {
    
    static let shared = ArticleEntity()
    
    private let tblArticles = Table("articles_content")
    
    private let articleId = Expression<Int>("docid")
    private let number = Expression<String>("c0number")
    private let title = Expression<String>("c1title")
    private let content = Expression<String>("c2content")
    private let favourite = Expression<Int>("c3favourite")
    private let chapterNumber = Expression<String>("c4chapter_number")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblArticles.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                    table.column(self.articleId)
                    table.column(self.number)
                    table.column(self.title)
                    table.column(self.content)
                    table.column(self.favourite)
                    table.column(self.chapterNumber)
                }))
                print ("Table Articles has been created")
            } else {
                print ("Fail creating the table Articles")
            }
        }catch {
            let nserror = error as NSError
            print("Fail creating the table Articles. Error: \(nserror)")
        }
    }
    

    
}
