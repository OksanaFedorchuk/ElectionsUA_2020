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
    
    private let number = Expression<String>("number")
    private let title = Expression<String>("title")
    private let content = Expression<String>("content")
    private let favourite = Expression<Int>("favourite")
    private let chapterNumber = Expression<String>("chapter_number")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblArticles.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
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
    
    func getArticlesFiltered(by selectedChapter: String) -> [[String]] {
        var articles = [[String]]()
        do {
            let filterCondition = (chapterNumber == selectedChapter)
            if let articlesArray = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for article in articlesArray {
                    let number = article[ArticleEntity.shared.number]
                    let title = article[ArticleEntity.shared.title]
                    articles.append([number, title])
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblArticles. Error: \(nserror), \(nserror.userInfo)")
        }
        return articles
    }
    
    // MARK: - Query for the title and content of selected article
    
    func getSelectedArticleFiltered(by selectedArticle: String) -> [[String]] {
        var article = [[String]]()
        do {
            let filterCondition = (number == selectedArticle)
            if let articleData = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for content in articleData {
                    let title = content[ArticleEntity.shared.title]
                    let content = content[ArticleEntity.shared.content]
                    article.append([title, content])
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return article
    }
    
    // MARK: - Queries for favorite articles
    
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
    
    func getFavouriteArticles() -> [[String]]{
        var favoriteArticles = [[String]]()
        do {
            let filterCondition = (favourite == 1)
            if let favoriteArticlesTable = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for favoriteArticle in favoriteArticlesTable {
                    let number = favoriteArticle[ArticleEntity.shared.number]
                    let title = favoriteArticle[ArticleEntity.shared.title]
                    favoriteArticles.append([number, title])
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return favoriteArticles
    }
    
    // MARK: - Queries for search
    
    //    func getSearchResults(filtered by: String) -> [String] {
    //
    //        return
    //    }
}
