//
//  SearchViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let db = ArticleEntity()
    
    var searchResult = [[[String]]]()
    var searchText = String()
    var content = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        db1.insert()
        
    }
    
    func updateData() {
        searchResult = db.getSearchResultsFiltered(by: searchText)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchCell
        
//        let titleString = searchResult[indexPath.row][1][0]
//        let labelT = titleString.getSubstring(of: titleString, searchTxt: searchText)
//        let contentString = searchResult[indexPath.row][2][0]
//        let labelC = contentString.getSubstring(of: contentString, searchTxt: searchText)
        
        
        cell.numberLabel.attributedText = searchResult[indexPath.row][0][0].highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica Light", size: 10)!)
        cell.titleLabel.attributedText = searchResult[indexPath.row][1][0].highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 16)!)
        cell.contentLabel.attributedText =  searchResult[indexPath.row][2][0].highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 14)!)
        print("\(searchResult[indexPath.row][0][0]) /n \(searchResult[indexPath.row][1][0]) /n \(searchResult[indexPath.row][2][0]) ")
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
        searchResult.removeAll()
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

//    func getSubstring(of string: String, searchTxt: String) -> String {
//        var substring = String()
//        let endIndex = String.Index(utf16Offset: string.count, in: string)
//        if let startIndex = string.range(of: searchTxt)?.lowerBound {
//            substring = String("...\(string[startIndex..<endIndex])...")
//        }
//        return substring
//    }
//
}
