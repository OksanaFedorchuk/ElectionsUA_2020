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
    
    private let tblArticles = Table("articles")
    
//    private let articleId = Expression<Int64>("docid")
    private let number = Expression<String>("number")
    private let title = Expression<String>("title")
    private let content = Expression<String>("content")
    private let favourite = Expression<Int>("favourite")
    private let chapterNumber = Expression<String>("chapter_number")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblArticles.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
//                    table.column(self.articleId)
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
    
    func getArticleNumbersFiltered(by selectedChapter: String) -> [String] {
        var articleNumbers = Array<String>()
        do {
            let filterCondition = (chapterNumber == selectedChapter)
            if let numbers = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for articleNumber in numbers {
                    let number = articleNumber[ArticleEntity.shared.number]
                    articleNumbers.append(number)
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblArticles. Error: \(nserror), \(nserror.userInfo)")
        }
        return articleNumbers
    }
    
    func getArticleTitleFiltered(by selectedChapter: String) -> [String] {
        var articleTitles = Array<String>()
        do {
            let filterCondition = (chapterNumber == selectedChapter)
            if let titles = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for articleTitle in titles {
                    let title = articleTitle[ArticleEntity.shared.title]
                    articleTitles.append(title)
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return articleTitles
    }
    
}