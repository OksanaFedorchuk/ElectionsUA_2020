//
//  FavoriveTableViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let db1 = ArticleEntity()
    
    private var articles = [Article]()
    private var selectedArticle = String()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    private func updateData() {
        articles = db1.getFavouriteArticles()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    // MARK: - Table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.Cell.FavoriteCell, for: indexPath) as! TableViewCell
        
        cell.numberLabel.text = articles[indexPath.row].number
        cell.contentLabel.text = articles[indexPath.row].title
        
        return cell
    }
    
    // MARK: - Swipe to delete method
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            db1.changeFavouriteArticleStatus(by: articles[indexPath.row].number, currentFavouriteStatus: 1)
            articles = db1.getFavouriteArticles()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FavArticleViewController {
            destinationVC.navigationItem.title = selectedArticle
            destinationVC.segueFlag = 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row].number
        self.performSegue(withIdentifier: K.Identifiers.Segue.GoToFavoriteArticle, sender: Any.self)
    }
}
