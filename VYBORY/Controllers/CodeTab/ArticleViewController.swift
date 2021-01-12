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
    var segueFlag = Int()
    var searchText = String()
    var searchArticles = [Article]()
    var oldFavs = [Article]()
    var newFavs = [Article]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        updateUI()
        super.viewDidLoad()
    }
    
    // MARK: - Like methods
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
//        if like tapped in favouriteVC
        if self.tabBarController?.selectedViewController == tabBarController?.viewControllers?[2] {
            segueFlag = 4
        }
//        get favourites before unliked article is removed
        oldFavs = db1.getFavouriteArticles()
//        change favourite status for the article
        getCurrentStatus()
        db1.changeFavouriteArticleStatus(by: navigationItem.title!, currentFavouriteStatus: currentStatus)
        getCurrentStatus()
        setCurrentStatusImage()
        newFavs = db1.getFavouriteArticles()
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
            //            all articles array
            articles = db1.getAllArticles()
        case 2:
            //            favourite articles array
            articles = db1.getFavouriteArticles()
        case 3:
            //            searched result articles array
            articles = searchArticles
        case 4:
            //            favourite articles array with unliked one
            articles = oldFavs
        default:
            print("You failed")
        }
        
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
        
        //        get indext of the previous article in array
        if currentIndex <= 0 {
            previous = articles[currentIndex]
        }
        else {
            previous = articles[currentIndex-1]
        }
        
        //        get indext of the next article in array
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
            //            if the selected article is not first in favourites array {}
            article = db1.getSelectedArticleFiltered(by: getSwipedArticle()[0].number)
//            didChangeCurrenItem?(article)
            updateUI()

            if oldFavs.first?.number != article[0].number {
                oldFavs = db1.getFavouriteArticles()
            }
            //            handling dislikes for two favs left in array?
        }
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            //            if the selected article is not last in favourites array {}
            article = db1.getSelectedArticleFiltered(by: getSwipedArticle()[1].number)
//            didChangeCurrenItem?(article)
            updateUI()

            if oldFavs.last?.number != article[0].number {
                oldFavs = db1.getFavouriteArticles()
            }
            //            handling dislikes for two favs left in array?
        }
    }
    
    
    // MARK: - UI update
    
    // updates fav image when come back to codeVC
    override func viewDidAppear(_ animated: Bool) {
        getCurrentStatus()
        setCurrentStatusImage()
    }
    
    func updateUI() {
        switch segueFlag {
        case 1:
            //            display selected article
            self.navigationItem.title = article[0].number
            //            change the title of navigationBar in articlesVC
            self.navigationController?.navigationBar.items?[2].title = article[0].chapterNumber
            //            change the title of navigationBar in chaptersVC and backbuttonTitle in articlesVC
            let chapter = db2.getChaptersFiltered(by: article[0].chapterNumber)
            self.navigationController?.navigationBar.items?[1].title = chapter[0].bookNumber
            self.navigationController?.navigationBar.items?[1].backBarButtonItem?.title = chapter[0].bookNumber
            
//            titleLabel.text = article[0].title
            
            let title = attributedArticle(targetString: String("\(article[0].title) \n \n"), fontSize: 16, fontWeight: UIFont.Weight.bold, fontColor: UIColor(named: "myPrimaLabel")!)!
            let content = attributedArticle(targetString: article[0].content, fontSize: 14, fontWeight: UIFont.Weight.regular, fontColor: UIColor(named: "myPrimaLabel")!)!
            
            let attributedArticle = NSMutableAttributedString()
            attributedArticle.append(title)
            attributedArticle.append(content)
            
            contentTextView.attributedText = attributedArticle
//                = NSAttributedString(string: "\(String(describing: title)) \n \(String(describing: content))")
            
//                String("\(article[0].title) \n \(article[0].content)")
                
            getCurrentStatus()
            setCurrentStatusImage()
            
        case 2, 4:
            //            display favourite article
            self.navigationItem.title = article[0].number
            titleLabel.text = article[0].title
            contentTextView.text = article[0].content
            getCurrentStatus()
            setCurrentStatusImage()
            
        case 3:
            //            display search result article with attributed blue searchText
            self.navigationItem.title = article[0].number
//            titleLabel.textColor = UIColor(named: "myPrimaLabel")
            titleLabel.attributedText = generateAttributedString(with: searchText, targetString: article[0].title, fontSize: 16, fontWeight: UIFont.Weight.bold)
            contentTextView.attributedText = generateAttributedString(with: searchText, targetString: article[0].content, fontSize: 15, fontWeight: UIFont.Weight.regular)
            getCurrentStatus()
            setCurrentStatusImage()
            
        default:
            print("You failed")
        }
    }
    
//    attribute searchText in the article
    
    func attributedArticle(targetString: String, fontSize: CGFloat, fontWeight: UIFont.Weight, fontColor: UIColor ) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: targetString)

            let range = NSRange(location: 0, length: targetString.utf16.count)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: fontColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: range)
            return attributedString
    }
    
    func generateAttributedString(with searchTerm: String, targetString: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: targetString)
        do {
            let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
            let range = NSRange(location: 0, length: targetString.utf16.count)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "myPrimaLabel")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: range)
            for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "myBlue")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: match.range)
            }
            return attributedString
        } catch {
            NSLog("Error creating regular expresion: \(error)")
            return nil
        }
    }
}
