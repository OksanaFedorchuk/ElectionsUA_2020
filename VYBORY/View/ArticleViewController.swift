//
//  ArticleViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticleViewController: UIViewController {
    
    // MARK: - Properties
    
    let db1 = ArticleEntity()
    var article = [Article]()
    var currentStatus = Int()
    var segueFlag = Int()
    var searchText = String()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Like methods
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        getCurrentStatus()
        db1.changeFavouriteArticleStatus(by: navigationItem.title!, currentFavouriteStatus: currentStatus)
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    func getCurrentStatus() {
        currentStatus = db1.getFavouriteArticleStatus(by: navigationItem.title!)
    }
    
    func setCurrentStatusImage() {
        if currentStatus == 0 {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
    }
    
    // MARK: - Swipe Gesture Methods
    
    func getSwipedArticle() -> [Article] {
        
        var articles = [Article]()
        
        switch segueFlag {
        case 1:
            articles = db1.getArticlesFiltered(by: article[0].chapterNumber)
        case 2:
            articles = db1.getFavouriteArticles()
        case 3:
            articles = db1.getTitleSearchResultsFiltered(by: searchText)
            
        default:
            print("You failed")
        }
        
        let searchValue = article[0]
        
        var currentIndex = 0
        var articlesTwo = [Article]()
        var next: Article
        var previous: Article
        
        for a in articles {
            if a.number == searchValue.number {
                break
            }
            currentIndex += 1
        }
        
        if currentIndex+1 >= articles.count {
            next = articles[currentIndex]
        }
        else {
            next = articles[currentIndex+1]
        }
        
        if currentIndex <= 0 {
            previous = articles[currentIndex]
        }
        else {
            previous = articles[currentIndex-1]
        }
        
        articlesTwo.append(previous)
        articlesTwo.append(next)
        
        return articlesTwo
    }
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .right) {
            article = db1.getSelectedArticleFiltered(by: getSwipedArticle()[0].number)
            updateUI()
        }
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            article = db1.getSelectedArticleFiltered(by: getSwipedArticle()[1].number)
            updateUI()
        }
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        updateUI()
        super.viewDidLoad()
    }
    
    // MARK: - UI update
    
    func updateUI() {
        navigationItem.title = article[0].number
        titleLabel.text = article[0].title
        contentLabel.text = article[0].content
        getCurrentStatus()
        setCurrentStatusImage()
    }
}
