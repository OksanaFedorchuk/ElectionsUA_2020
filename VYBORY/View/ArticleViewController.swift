//
//  ArticleViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticleViewController: UIViewController {
    
    let db1 = ArticleEntity()
    var articleTitle = String()
    var articleContent = String()
    
    var currentStatus = Int()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {

        getCurrentStatus()
        db1.changeFavouriteArticleStatus(by: navigationItem.title!, currentFavouriteStatus: currentStatus)
        getCurrentStatus()
        setCurrentStatusImage()
        
    }
    
    override func viewDidLoad() {
        updateData()
        getCurrentStatus()
        setCurrentStatusImage()
        super.viewDidLoad()
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
    
    func updateData() {
        
        articleTitle = db1.getSelectedArticleTitleFiltered(by: navigationItem.title!)
        articleContent = db1.getSelectedArticleContentFiltered(by: navigationItem.title!)
        titleLabel.text = articleTitle
        contentLabel.text = articleContent
    }
}
