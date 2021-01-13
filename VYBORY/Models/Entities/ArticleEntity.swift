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
    
    private let tblArticles = VirtualTable(K.Database.Table.Articles)
    
    private let number = Expression<String>(K.Database.Row.Number)
    private let title = Expression<String>(K.Database.Row.Title)
    private let content = Expression<String>(K.Database.Row.Content)
    private let favourite = Expression<Int>(K.Database.Row.Favourite)
    private let chapterNumber = Expression<String>(K.Database.Row.ChapterNumber)
    
    lazy var snippet = snippetWrapper(column: content, tableName: K.Database.Table.Articles)
    
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblArticles.create(.FTS4(number, title, content, favourite, chapterNumber), ifNotExists: true))
            } else {
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Query for the list of articles in selected chapter
    
    func getAllArticles() -> [Article] {
        var articles = [Article]()
        
        do {
            if let articlesVtable = try Database.shared.connection?.prepare(tblArticles) {
                for a in articlesVtable {
                    if a[ArticleEntity.shared.title] != K.Database.NilItem {
                        let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.content], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                        articles.append(article)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return articles
    }
    
    func getArticlesFiltered(by selectedChapter: String) -> [Article] {
        var articles = [Article]()
        
        do {
            if let articlesVtable = try Database.shared.connection?.prepare(tblArticles.filter(chapterNumber.match("\(selectedChapter)"))) {
                for a in articlesVtable {
                    if a[ArticleEntity.shared.title] != K.Database.NilItem {
                        let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.content], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                        articles.append(article)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return articles
    }
    
    // MARK: - Query for the selected article
    
    func getSelectedArticleFiltered(by selectedArticle: String) -> [Article] {
        var articles = [Article]()
        do {
            if let articleData = try Database.shared.connection?.prepare(tblArticles.filter(number.match("\(selectedArticle)"))) {
                for a in articleData {
                    let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.content], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                    articles.append(article)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return articles
    }
    
    // MARK: - Queries for favorite articles
    
    func getFavouriteArticleStatus(by selectedArticle: String) -> Int {
        var articleStatus = Int()
        do {
            if let requests = try Database.shared.connection?.prepare(tblArticles.filter(number.match("\(selectedArticle)"))) {
                for request in requests {
                    articleStatus = request[ArticleEntity.shared.favourite]
                }
            }
        } catch {
            print(error.localizedDescription)
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
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavouriteArticles() -> [Article]{
        var favoriteArticles = [Article]()
        do {
            let filterCondition = (favourite == 1)
            if let favoriteArticlesTable = try Database.shared.connection?.prepare(self.tblArticles.filter(filterCondition)) {
                for a in favoriteArticlesTable {
                    let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.content], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                    favoriteArticles.append(article)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return favoriteArticles
    }
    
    // MARK: - Query for search
    
    func getTitleSearchResultsFiltered(by searchText: String) -> [Article] {
        var searchResult = [Article]()
        do {
            
            if let results = try Database.shared.connection?.prepare(tblArticles.select(number, title, content, favourite, chapterNumber).filter(title.match("\(searchText)*"))) {
                for a in results {
                    if a[ArticleEntity.shared.title] != K.Database.NilItem {
                        let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.content], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                        searchResult.append(article)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return searchResult
    }
    
    func getContentSearchResultsFiltered(by searchText: String) -> [Article] {
        var searchResult = [Article]()
        do {
            if let results2 = try Database.shared.connection?.prepare(tblArticles.select(number, title, snippet, favourite, chapterNumber).filter(content.match("\(searchText)*"))) {
                for a in results2 {
                    if a[ArticleEntity.shared.title] != K.Database.NilItem {
                        let article = Article(number: a[ArticleEntity.shared.number], title: a[ArticleEntity.shared.title], content: a[ArticleEntity.shared.snippet], favourite: a[ArticleEntity.shared.favourite], chapterNumber: a[ArticleEntity.shared.chapterNumber])
                        searchResult.append(article)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return searchResult
    }
    
    func snippetWrapper(column: Expression<String>, tableName: String) -> Expression<String> {
        return Expression("snippet(\(tableName), '', '', '...')", column.bindings)
    }
}
