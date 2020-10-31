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
    var articleFavouriteStatus = Int()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        
        let currentStatus = db1.getFavouriteArticleStatus(by: navigationItem.title!)
        
        db1.changeFavouriteArticleStatus(by: navigationItem.title!, currentFavouriteStatus: currentStatus)
        
        if currentStatus == 0 {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    func updateData() {
        
        articleTitle = db1.getSelectedArticleTitleFiltered(by: navigationItem.title!)
        articleContent = db1.getSelectedArticleContentFiltered(by: navigationItem.title!)
        titleLabel.text = articleTitle
        contentLabel.text = articleContent
    }
}
