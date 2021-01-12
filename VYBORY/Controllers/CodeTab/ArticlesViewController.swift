//
//  ArticlesViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 29.10.2020.
//

import UIKit

class ArticlesViewController: UITableViewController {
    
    let db1 = ArticleEntity()

    var articles = [Article]()
    var currentArticle = Article(number: "", title: "", content: "", favourite: 0, chapterNumber: "")

    
    
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
        cell.numberLabel.text = articles[indexPath.row].number
        cell.contentLabel.text = articles[indexPath.row].title
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.navigationItem.title = currentArticle.number
            destinationVC.segueFlag = 1
            destinationVC.navigationItem.backButtonTitle = currentArticle.chapterNumber
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentArticle = articles[indexPath.row]
        if articles[indexPath.row].title != "Виключена." {
            self.performSegue(withIdentifier: "goToArticle", sender: Any.self)
        }
    }


}
