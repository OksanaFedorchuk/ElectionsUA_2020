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
    var searchArticles = [Article]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    
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
            articles = searchArticles
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
        switch segueFlag {
        case 1:
            navigationItem.title = article[0].number
            titleLabel.text = article[0].title
            contentTextView.text = article[0].content
            getCurrentStatus()
            setCurrentStatusImage()
        //            articles = db1.getArticlesFiltered(by: article[0].chapterNumber)
        case 2:
            
            navigationItem.title = article[0].number
            titleLabel.text = article[0].title
            contentTextView.text = article[0].content
            getCurrentStatus()
            setCurrentStatusImage()
        //            articles = db1.getFavouriteArticles()
        case 3:
            //            contentTextView.textColor = .label
            navigationItem.title = article[0].number
            titleLabel.attributedText = generateAttributedString(with: searchText, targetString: article[0].title, fontSize: 16, fontWeight: UIFont.Weight.bold)
            contentTextView.attributedText = generateAttributedString(with: searchText, targetString: article[0].content, fontSize: 15, fontWeight: UIFont.Weight.regular)
            getCurrentStatus()
            setCurrentStatusImage()
        //            articles = searchArticles
        default:
            print("You failed")
        }
    }
    
    func generateAttributedString(with searchTerm: String, targetString: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: targetString)
        do {
            let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
            let range = NSRange(location: 0, length: targetString.utf16.count)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: range)
            for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: match.range)
            }
            return attributedString
        } catch {
            NSLog("Error creating regular expresion: \(error)")
            return nil
        }
    }
}
