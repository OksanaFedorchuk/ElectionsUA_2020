//
//  SearchViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let db = ArticleEntity()
    
    var allTheData = [[Article]]()
    
    var titleSearchResult = [Article]()
    var contentSearchResult = [Article]()
    var searchText = String()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // MARK: - Data Manipulation Methods
    
    func updateData() {
        titleSearchResult = db.getTitleSearchResultsFiltered(by: searchText)
        contentSearchResult = db.getContentSearchResultsFiltered(by: searchText)
        let diff = unique(array1: titleSearchResult, array2: contentSearchResult)
        allTheData = [titleSearchResult, diff]
        tableView.reloadData()
    }
    
    func unique(array1: [Article], array2: [Article]) -> [Article] {
        var uniqueArticles = [Article]()
        
        for article2 in array2 {
            var f = false
            
            for article1 in array1 {
                
                if article2.number == article1.number {
                    f = true
                }
            }
            
            if f == false {
                uniqueArticles.append(article2)
            }
        }
        return uniqueArticles
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        allTheData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleSearchResultCell", for: indexPath) as! SearchCell
        
        
        cell.numberLabel.attributedText = allTheData[indexPath.section][indexPath.row].number.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica Light", size: 10)!)
        cell.titleLabel.attributedText = allTheData[indexPath.section][indexPath.row].title.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 16)!)
        cell.contentLabel.attributedText =  allTheData[indexPath.section][indexPath.row].content.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 14)!)
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */
    
}
// MARK: - Search Bar Delegate Methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
        }
        allTheData.removeAll()
        updateData()
    }
    
}

extension String {
    
    func highlightText(
        _ text: String,
        with color: UIColor,
        caseInsensitivie: Bool = false,
        font: UIFont = .preferredFont(forTextStyle: .body)) -> NSAttributedString
    {
        let attrString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: text, options: caseInsensitivie ? .caseInsensitive : [])
        attrString.addAttribute(
            .foregroundColor,
            value: color,
            range: range)
        attrString.addAttribute(
            .font,
            value: font,
            range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
}
