//
//  CodViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CodeViewController: UICollectionViewController {
    
    
    let db = BookEntity()
    let bookImages = ["01_book_01", "01_book_02", "01_book_03", "01_book_04"]
    
    var books = [[String]]()
    var selectedBook = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        
    }
    // MARK: UICollectionViewDataSource
    
    func loadBooks() {
        books = db.getBooks()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        bookCell.bookNumber.text = books[indexPath.row][0]
        bookCell.bookTitle.text = books[indexPath.row][1]
        bookCell.bookImage.image = UIImage(named: bookImages[indexPath.row])
        
        return bookCell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ChaptersViewController {
            destinationVC.navigationItem.title = selectedBook
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedBook = books[indexPath.row][0]
        self.performSegue(withIdentifier: "GoToChapter", sender: Any.self)
    }
}


// MARK: - FlowLayout
extension CodeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/2
        return CGSize(width: width,
                      height: width)
    }
}

