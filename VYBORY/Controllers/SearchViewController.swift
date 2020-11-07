//
//  SearchViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let db = ArticleEntity()
    
    //    var searchResult = [String]()
    var searchResult = [[[String]]]()
    var searchText = String()
    var content = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateData() {
//        let lowercased = searchText.lowercased()
        searchResult = db.getSearchResultsFiltered(by: searchText)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchCell
        
        let string = searchResult[indexPath.row][2][0]
        let label = string.getSubstring(of: string, searchTxt: searchText)
        cell.numberLabel.attributedText = searchResult[indexPath.row][0][0].highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica Light", size: 10)!)
        cell.titleLabel.attributedText = searchResult[indexPath.row][1][0].highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 16)!)
        cell.contentLabel.attributedText =  label.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 14)!)
//
        return cell
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
// MARK: - Search Bar Delegate Methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text!.lowercased()
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
    
    func getSubstring(of string: String, searchTxt: String) -> String {
        var substring = String()
        let endIndex = String.Index(utf16Offset: string.count, in: string)
        if let startIndex = string.range(of: searchTxt)?.lowerBound {
            substring = String("...\(string[startIndex..<endIndex])...")
        }
        return substring
    }
    
}
