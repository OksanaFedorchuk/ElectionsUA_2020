//
//  SearchArticleViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 20.01.2021.
//

import UIKit

class SearchArticleViewController: UIViewController {
    
    
    // MARK: - Properties
    
    let db1 = ArticleEntity()
    
    var article = [Article]()
    var currentStatus = Int()
    var segueFlag = Int()
    
    var searchText = String()
    var searchArticles = [Article]()
    
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        updateUI()
        super.viewDidLoad()
    }
    
    // MARK: - Like methods
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        
        //        change favourite status for the article
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
        
        //            let articles = searchArticles
        
        //        current view article
        let currentArticle = article[0]
        
        
        var currentIndex = 0
        var previousAndNextArticles = [Article]()
        var previous: Article
        var next: Article
        
        //        get the index of current article in array
        for a in searchArticles {
            if a.number == currentArticle.number {
                break
            }
            currentIndex += 1
        }
        
        //        get index of the previous article in array
        if currentIndex <= 0 {
            previous = searchArticles[currentIndex]
        }
        else {
            previous = searchArticles[currentIndex-1]
        }
        
        //        get index of the next article in array
        if currentIndex+1 >= searchArticles.count {
            next = searchArticles[currentIndex]
        }
        else {
            next = searchArticles[currentIndex+1]
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
    
    // updates fav image when come back to VC
    override func viewDidAppear(_ animated: Bool) {
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    func updateUI() {
        //            display search result article with attributed blue searchText
        self.navigationItem.title = article[0].number
        contentTextView.attributedText = generateAttributedArticleText(searchText: searchText, titleText: article[0].title, contentText: article[0].content)
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    //    make an attributed string containing title and content of the article
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
