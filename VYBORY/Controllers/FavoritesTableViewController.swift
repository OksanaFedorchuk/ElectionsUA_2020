//
//  FavoriveTableViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let segueId = "goToFavoriteArticle"
    let db1 = ArticleEntity()
    
    var articles = [Article]()
    var selectedArticle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        articles = db1.getFavouriteArticles()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        
        cell.numberLabel.text = articles[indexPath.row].number
        cell.contentLabel.text = articles[indexPath.row].title
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.navigationItem.title = selectedArticle
            destinationVC.segueFlag = 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row].number
        let selectedTitle = articles[indexPath.row].title
        if selectedTitle != "Виключена." {
            self.performSegue(withIdentifier: segueId, sender: Any.self)
        }
    }
}
