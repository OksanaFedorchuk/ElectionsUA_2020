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
    
    // MARK: - Query for the list of articles in chapter
    
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
    
    // MARK: - Query for the title and content of selected article
    
    func getSelectedArticleTitleFiltered(by selectedArticle: String) -> String {
        var articleTitles = String()
        do {
            let filterCondition = (number == selectedArticle)
            if let titles = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for articleTitle in titles {
                    articleTitles = articleTitle[ArticleEntity.shared.title]

                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return articleTitles
    }
    
    func getSelectedArticleContentFiltered(by selectedArticle: String) -> String {
        var articleContent = String()
        do {
            let filterCondition = (number == selectedArticle)
            if let requests = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for request in requests {
                        articleContent = request[ArticleEntity.shared.content]
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return articleContent
    }
    
    func changeFavouriteArticleStatus(by selectedArticle: String, currentFavouriteStatus: Int) {
        var status = Int()
        do {
            let article = tblArticles.filter(number == selectedArticle)
            status = currentFavouriteStatus == 0 ? 1 : 0
            do {
                try Database.shared.connection?.run(article.update(favourite <- status))
            }
            catch {
                print("Unable to shange the favorite article status. Error is: \(error)")
            }
        }
    }
    
    func getFavouriteArticleStatus(by selectedArticle: String) -> Int {
       var articleStatus = Int()
       do {
           let filterCondition = (number == selectedArticle)
           if let requests = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
               for request in requests {
                articleStatus = request[ArticleEntity.shared.favourite]
               }
           }
       } catch {
           let nserror = error as NSError
           print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
       }
       return articleStatus
   }
    
    
}
