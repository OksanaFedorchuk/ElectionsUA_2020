//
//  FavoriveTableViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    let segueId = "goToFavoriteArticle"
    
    let db1 = ArticleEntity()
    var articles = [String()]
    var articleTitles = [String()]
    
    var selectedArticle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        tableView.reloadData()
    }
    
    func updateData() {
        articles = db1.getFavouriteArticlesNumber()
        articleTitles = db1.getFavouriteArticlesTitle()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
//
//        cell.accessoryView = UIImageView(image: UIImage(systemName: "heart.fill"), highlightedImage: UIImage(systemName: "heart.fill"))
//        cell.accessoryType = .checkmark
        cell.numberLabel.text = articles[indexPath.row]
        cell.contentLabel.text = articleTitles[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        tableView.reloadData()
    }

     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.navigationItem.title = selectedArticle
//            navigationItem.backBarButtonItem = UIBarButtonItem(title: navigationItem.title, style: .plain, target: nil, action: nil)
        }
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row]
        let selectedTitle = articleTitles[indexPath.row]
        if selectedTitle != "Виключена." {
        self.performSegue(withIdentifier: segueId, sender: Any.self)
        }
    }
}
