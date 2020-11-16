//
//  ArticleEntity.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 28.10.2020.
//

import Foundation
import SQLite
import sqlite3

class ArticleEntity {
    
    static let shared = ArticleEntity()
    
    private let tblArticles = VirtualTable("articles")
    
    private let number = Expression<String>("number")
    private let title = Expression<String>("title")
    private let content = Expression<String>("content")
    private let favourite = Expression<Int>("favourite")
    private let chapterNumber = Expression<String>("chapter_number")
    
    lazy var snippet = snippetWrapper(column: content, tableName: "articles")
    
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblArticles.create(.FTS4(number, title, content, favourite, chapterNumber), ifNotExists: true))
                print ("Table Articles has been created")
            } else {
                print ("Fail creating the table Articles")
            }
        }catch {
            print("Fail creating the table Articles. Error: \(error), \(error.localizedDescription)")
        }
    }
    
    // MARK: - Query for the list of articles in chapter
    
    func getArticlesFiltered(by selectedChapter: String) -> [[String]] {
        var articles = [[String]]()
        do {
            if let articlesVtable = try Database.shared.connection?.prepare(tblArticles.filter(chapterNumber.match("\(selectedChapter)*"))) {
                for a in articlesVtable {
                    
                    let number = a[ArticleEntity.shared.number]
                    let title = a[ArticleEntity.shared.title]
                    articles.append([number, title])
                }
            }
        } catch {
            print("Cannot list quesry objects in tblArticles. Error: \(error), \(error.localizedDescription)")
        }
        return articles
    }
    
    // MARK: - Query for the title and content of selected article
    
    func getSelectedArticleFiltered(by selectedArticle: String) -> [[String]] {
        var article = [[String]]()
        do {
            if let articleData = try Database.shared.connection?.prepare(tblArticles.filter(number.match("\(selectedArticle)*"))) {
                for content in articleData {
                    let title = content[ArticleEntity.shared.title]
                    let content = content[ArticleEntity.shared.content]
                    article.append([title, content])
                }
            }
        } catch {
            print("Cannot list quesry objects in tblChapters. Error: \(error), \(error.localizedDescription)")
        }
        return article
    }
    
    // MARK: - Queries for favorite articles
    
    func getFavouriteArticleStatus(by selectedArticle: String) -> Int {
        var articleStatus = Int()
        do {
            //        let filterCondition = (number == selectedArticle)
            if let requests = try Database.shared.connection?.prepare(tblArticles.filter(number.match("\(selectedArticle)*"))) {
                for request in requests {
                    articleStatus = request[ArticleEntity.shared.favourite]
                }
            }
        } catch {
            print("Cannot list quesry objects in tblChapters. Error: \(error), \(error.localizedDescription)")
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
                print("Unable to shange the favorite article status. Error is: \(error), \(error.localizedDescription)")
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
            print("Cannot list quesry objects in tblChapters. Error: \(error), \(error.localizedDescription)")
        }
        return favoriteArticles
    }
    
    // MARK: - Queries for search
    
    func getSearchResultsFiltered(by searchText: String) -> [[[String]]] {
        var searchResult = [[[String]]]()
//        do {
//            if let results = try Database.shared.connection?.prepare(tblArticles.select(number, title, content).filter(title.match("\(searchText)*"))) {
//                for result in results {
//                    let number = result[ArticleEntity.shared.number]
//                    let title = result[ArticleEntity.shared.title]
//                    let content = result[ArticleEntity.shared.content]
//                    searchResult.append([[number], [title], [content]])
//                }
//            }
//        } catch {
//            print("Cannot list quesry objects in tblChapters. Error: \(error), \(error.localizedDescription)")
//        }

        do {
            if let results2 = try Database.shared.connection?.prepare(tblArticles.select(number, title, snippet).filter(content.match("\(searchText)*"))) {
                for result in results2 {
                    let number = result[ArticleEntity.shared.number]
                    let title = result[ArticleEntity.shared.title]
                    let content = result[ArticleEntity.shared.snippet]
                    searchResult.append([[number], [title], [content]])
                }
            }
        } catch {
            print("Cannot list quesry objects in tblChapters. Error: \(error), \(error.localizedDescription)")
        }
        return searchResult
    }
    
    func snippetWrapper(column: Expression<String>, tableName: String) -> Expression<String> {
        return Expression("snippet(\(tableName), '', '', '...')", column.bindings)
      }
    
}
