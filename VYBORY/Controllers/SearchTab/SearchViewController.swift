//
//  SearchViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class SearchViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let db = ArticleEntity()

    //    properties to propagate table, titles first section, content second section
    var allTheData = [[Article]]()
    var titleSearchResult = [Article]()
    var contentSearchResult = [Article]()
    var diff = [Article]()
    
    // array of retrieved search articles for swipes in article view
    var allSearchArticles = [Article]()
    
    var searchText = String()
    var selectedArticle = String()
    
    //    dog placeholder
    lazy var noResultsView = NoContentView(frame: tableView.bounds.offsetBy(dx: 0, dy: searchBar.frame.maxY))
    
    enum PlaceholderViewMode {
        case hidden
        case searchDog
        case sadDog
    }
    
    
    override func viewDidLoad() {
        
        addPlaceholerView()
        configurePlaceholderView(with: .searchDog)
        super.viewDidLoad()
        
    }
    
    // MARK: - Placeholder Methods
    
    func addPlaceholerView() {
        view.addSubview(noResultsView)
        noResultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchBar.frame.height + 50),
            noResultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }
    
    func configurePlaceholderView(with type: PlaceholderViewMode) {
        switch type {
        
        case .hidden:
            noResultsView.isHidden = true
            
        case .searchDog:
            noResultsView.isHidden = false
            noResultsView.noContImage.image = K.Placeholder.Image.Dog
            noResultsView.noContLabel.text = K.Placeholder.Text.FindSomething
            
        case .sadDog:
            noResultsView.isHidden = false
            self.noResultsView.noContImage.image = K.Placeholder.Image.DogCry
            self.noResultsView.noContLabel.text = K.Placeholder.Text.NothingFound
        }
    }
    
    // MARK: - Data Manipulation Methods
    //    retrieve db rows using searchText
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
        
        configurePlaceholderView(with: .hidden)
        
        let searchResultCell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.Cell.SearchResultCell, for: indexPath) as! SearchCell
        
        searchResultCell.numberLabel.attributedText = allTheData[indexPath.section][indexPath.row]
            .number
            .highlightText(searchText, with: K.Color.MyBlue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 12)!)
        
        searchResultCell.titleLabel.attributedText = allTheData[indexPath.section][indexPath.row]
            .title
            .highlightText(searchText, with: K.Color.MyPrimaLabel, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 16)!)
        
        searchResultCell.contentLabel.attributedText =  allTheData[indexPath.section][indexPath.row]
            .content
            .highlightText(searchText, with: K.Color.MyBlue, caseInsensitivie: true, font: UIFont(name: "Helvetica", size: 14)!)
        
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
        self.performSegue(withIdentifier: K.Identifiers.Segue.GoToSearchArticle, sender: Any.self)
    }
}
// MARK: - Search Bar Delegate Methods

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configurePlaceholderView(with: .searchDog)
        allTheData.removeAll()
        updateData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if ((searchBar.text?.isEmpty) == true) {
            
            configurePlaceholderView(with: .searchDog)
            allTheData.removeAll()
            tableView.reloadData()
        }
        else {
            
            if let text = searchBar.text {
                self.searchText = text
                allTheData.removeAll()
                updateData()
                
                if self.titleSearchResult.count + self.contentSearchResult.count == 0 {
                    configurePlaceholderView(with: .sadDog)
                    tableView.reloadData()
                }
            }
        }
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
