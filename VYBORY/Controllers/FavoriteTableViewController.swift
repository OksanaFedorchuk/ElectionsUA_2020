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
        
        cell.numberLabel.text = articles[indexPath.row]
        cell.contentLabel.text = articleTitles[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        tableView.reloadData()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
