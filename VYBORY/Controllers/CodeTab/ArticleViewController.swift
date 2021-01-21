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
    let db2 = ChapterEntity()
    
    var article = [Article]()
    var currentStatus = Int()
    
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        updateUI()
        super.viewDidLoad()
    }
    
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
            navigationItem.rightBarButtonItem?.image = K.Image.heart
        } else {
            navigationItem.rightBarButtonItem?.image = K.Image.heartFill
        }
    }
    
    // MARK: - Swipe Gesture Methods
    
    func getSwipedArticle() -> [Article] {
        
        let articles = db1.getAllArticles()
        
        //        current view article
        let currentArticle = article[0]
        
        
        var currentIndex = 0
        var previousAndNextArticles = [Article]()
        var previous: Article
        var next: Article
        
        //        get the index of current article in array
        for a in articles {
            if a.number == currentArticle.number {
                break
            }
            currentIndex += 1
        }
        
        //        get index of the previous article in array
        if currentIndex <= 0 {
            previous = articles[currentIndex]
        }
        else {
            previous = articles[currentIndex-1]
        }
        
        //        get index of the next article in array
        if currentIndex+1 >= articles.count {
            next = articles[currentIndex]
        }
        else {
            next = articles[currentIndex+1]
        }
        
        previousAndNextArticles.append(previous)
        previousAndNextArticles.append(next)
        
        return previousAndNextArticles
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
    
    
    // MARK: - UI update methods
    
    // updates fav image when come back to codeVC
    override func viewDidAppear(_ animated: Bool) {
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    func updateUI() {
        //            display selected article
        self.navigationItem.title = article[0].number
        //            change the title of navigationBar in articlesVC
        self.navigationController?.navigationBar.items?[2].title = article[0].chapterNumber
        //            change the title of navigationBar in chaptersVC and backbuttonTitle in articlesVC
        let chapter = db2.getChaptersFiltered(by: article[0].chapterNumber)
        self.navigationController?.navigationBar.items?[1].title = chapter[0].bookNumber
        self.navigationController?.navigationBar.items?[1].backBarButtonItem?.title = chapter[0].bookNumber
        
        
        contentTextView.attributedText = generateAttributedArticleText(searchText: nil, titleText: article[0].title, contentText: article[0].content)
        
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    //    make an attributed string containing title and content of an article
    func generateAttributedArticleText(searchText: String?, titleText: String, contentText: String) -> NSAttributedString {
        
        let title = titleText.highlightText(highlight: nil, fontSize: 17, fontWeight: UIFont.Weight.bold, caseInsensitivie: true)!
        let content = contentText.highlightText(highlight: nil, fontSize: 15, fontWeight: UIFont.Weight.regular, caseInsensitivie: true)!
        let attributedArticle = NSMutableAttributedString()
        
        attributedArticle.append(title)
        attributedArticle.append(NSAttributedString(string: " \n \n"))
        attributedArticle.append(content)
        
        return attributedArticle
    }
}
