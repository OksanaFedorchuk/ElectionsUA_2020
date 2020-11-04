//
//  ArticlesViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticlesViewController: UITableViewController {
    
    let db1 = ArticleEntity()
    
    
    var articles = [[String]]()
    var selectedArticle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    // MARK: - Table view data source
    
    func updateData() {
        articles = db1.getArticlesFiltered(by: navigationItem.title!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleViewCell", for: indexPath) as! TableViewCell
        cell.numberLabel.text = articles[indexPath.row][0]
        cell.contentLabel.text = articles[indexPath.row][1]
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.navigationItem.title = selectedArticle
            navigationItem.backBarButtonItem = UIBarButtonItem(title: navigationItem.title, style: .plain, target: nil, action: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row][0]
        let selectedTitle = articles[indexPath.row][1]
        if selectedTitle != "Виключена." {
            self.performSegue(withIdentifier: "goToArticle", sender: Any.self)
        }
    }
    
    
}
