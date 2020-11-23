//
//  ArticleViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticleViewController: UIViewController {
    
    let db1 = ArticleEntity()
    var article = [Article]()
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
        
        article = db1.getSelectedArticleFiltered(by: navigationItem.title!)
        titleLabel.text = article[0].title
        contentLabel.text = article[0].content
    }
}
