//
//  ChapterViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 27.10.2020.
//

import UIKit

class ChapterViewController: UITableViewController {
    
    let db = ChaptersEntity()
    
    var chapters = [String]()
    var titles = [String]()
    var selectedChapter = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }

    // MARK: - Table view data source
    
    func updateData() {
        chapters = db.getChapterNumbersFiltered(by: navigationItem.title!)
        titles = db.getChapterTitleFiltered(by: navigationItem.title!)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.numberLabel.text = chapters[indexPath.row]
        cell.contentLabel.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChapter = chapters[indexPath.row]
    }

}
