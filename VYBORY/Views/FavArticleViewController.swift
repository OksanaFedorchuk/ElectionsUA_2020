//
//  FArticleViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 20.01.2021.
//

import UIKit

class FavArticleViewController: UIViewController {
    
    
    // MARK: - Properties
    
    let db1 = ArticleEntity()
    
    var article = [Article]()
    var currentStatus = Int()
    var segueFlag = Int()
    var oldFavs = [Article]()
    
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        updateUI()
        super.viewDidLoad()
    }
    
    // MARK: - Like methods
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        
        //        favourite articles array with unliked one
        oldFavs = db1.getFavouriteArticles()
        segueFlag = 1
        
        
        //        change favourite status for the article
        getCurrentStatus()
        db1.changeFavouriteArticleStatus(by: navigationItem.title!, currentFavouriteStatus: currentStatus)
        getCurrentStatus()
        setCurrentStatusImage()
        //        favourite articles array
        let newFavs = db1.getFavouriteArticles()
        //        if the current article is liked two times at once
        if oldFavs.count < newFavs.count {
            oldFavs = newFavs
        }
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
            //            favourite articles array with unliked one
            articles = oldFavs
        case 2:
            //            favourite articles array
            articles = db1.getFavouriteArticles()
            
        default:
            print("Segue flag error")
        }
        
        //        current article
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
            //            if article is the first in array
            previous = articles[currentIndex]
        }
        else {
            previous = articles[currentIndex-1]
        }
        
        //        get index of the next article in array
        if currentIndex+1 >= articles.count {
            //            if the article is the last in array
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
            //            if the swiped article is liked, update array
            if article[0].favourite == 1 {
                segueFlag = 2
            }
        }
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            
            article = db1.getSelectedArticleFiltered(by: getSwipedArticle()[1].number)
            updateUI()
            //            if the swiped article is liked, update array
            if article[0].favourite == 1 {
                segueFlag = 2
            }
        }
    }
    
    // MARK: - UI update methods
    
    // updates fav image when come back to codeVC
    override func viewDidAppear(_ animated: Bool) {
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    func updateUI() {
        
        //            display favourite article
        self.navigationItem.title = article[0].number
        contentTextView.attributedText = generateAttributedArticleText(searchText: nil, titleText: article[0].title, contentText: article[0].content)
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    //    make an attributed string containing title and content of an article
    func generateAttributedArticleText(searchText: String?, titleText: String, contentText: String) -> NSAttributedString {
        
        let title = titleText.highlightText(highlight: searchText, fontSize: 17, fontWeight: UIFont.Weight.bold, caseInsensitivie: true)!
        let content = contentText.highlightText(highlight: searchText, fontSize: 15, fontWeight: UIFont.Weight.regular, caseInsensitivie: true)!
        
        let attributedArticle = NSMutableAttributedString()
        attributedArticle.append(title)
        attributedArticle.append(NSAttributedString(string: " \n \n"))
        attributedArticle.append(content)
        
        return attributedArticle
    }
}
