//
//  ChaptersViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 27.10.2020.
//

import UIKit

class ChaptersViewController: UITableViewController {
    
    let db = ChapterEntity()
    
    var chapters = [Chapter]()
    var currentChapter = Chapter(number: "", title: "", bookNumber: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
    }
    
    // MARK: - Table view data source
    
    func updateData() {
        chapters = db.getChaptersFiltered(by: navigationItem.title!)
    }
    
    //    get current chapters when returning using back button
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.numberLabel.text = chapters[indexPath.row].number
        cell.contentLabel.text = chapters[indexPath.row].title
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ArticlesViewController {
            destinationVC.navigationItem.title = currentChapter.number
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: navigationItem.title, style: .plain, target: nil, action: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentChapter = chapters[indexPath.row]
        self.performSegue(withIdentifier: "goToArticles", sender: Any.self)
    }
    
}
