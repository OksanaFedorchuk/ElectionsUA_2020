//
//  ArticlesViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticlesViewController: UITableViewController {
    
    let db1 = ArticleEntity()

    
    var articles = [String]()
    var articleTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }

    // MARK: - Table view data source
    
    func updateData() {
        articles = db1.getArticleNumbersFiltered(by: navigationItem.title!)
        articleTitles = db1.getArticleTitleFiltered(by: navigationItem.title!)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleViewCell", for: indexPath) as! TableViewCell

        cell.numberLabel.text = articles[indexPath.row]
        cell.contentLabel.text = articleTitles[indexPath.row]

        return cell
    }
    

    // MARK: - Navigation
    


}
