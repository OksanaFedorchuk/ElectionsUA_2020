//
//  SearchViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let db = ArticleEntity()
    let segueId = "goToSearchArticle"
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var allTheData = [[Article]]()
    
    var titleSearchResult = [Article]()
    var contentSearchResult = [Article]()
    var searchText = String()
    var selectedArticle = String()
    var diff = [Article]()
    var allSearchArticles = [Article]()
    
    
    override func viewDidLoad() {
        
        backgroundImage.image = UIImage(named: "dog_1")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.insertSubview(backgroundImage, at: 0)
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        super.viewDidLoad()
        updateData()
        
    }
    
    // MARK: - Data Manipulation Methods
    
    func updateImage() {
        if self.titleSearchResult.count + self.contentSearchResult.count == 0 {
            self.backgroundImage.image = UIImage(named: "dog_2")
        }
        
        tableView.reloadData()
    }
    
    func updateData() {
        titleSearchResult = db.getTitleSearchResultsFiltered(by: searchText)
        contentSearchResult = db.getContentSearchResultsFiltered(by: searchText)
        diff = unique(array1: titleSearchResult, array2: contentSearchResult)
        allTheData = [titleSearchResult, diff]
        allSearchArticles = titleSearchResult + diff
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
        return allTheData.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        backgroundImage.image = .none
        
        let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "titleSearchResultCell", for: indexPath) as! SearchCell
        
        searchResultCell.numberLabel.attributedText = allTheData[indexPath.section][indexPath.row].number.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica Light", size: 10)!)
        searchResultCell.titleLabel.attributedText = allTheData[indexPath.section][indexPath.row].title.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 16)!)
        searchResultCell.contentLabel.attributedText =  allTheData[indexPath.section][indexPath.row].content.highlightText(searchText, with: .blue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 14)!)
        
        return searchResultCell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ArticleViewController {
            destinationVC.navigationItem.title = selectedArticle
            destinationVC.segueFlag = 3
            destinationVC.searchText = searchText
            
            destinationVC.searchArticles = allSearchArticles
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = allTheData[indexPath.section][indexPath.row].number
        let selectedTitle = allTheData[indexPath.section][indexPath.row].title
        if selectedTitle != "Виключена." {
            self.performSegue(withIdentifier: segueId, sender: Any.self)
        }
    }
}
// MARK: - Search Bar Delegate Methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            self.searchText = text
        }
        allTheData.removeAll()
        updateData()
        updateImage()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
