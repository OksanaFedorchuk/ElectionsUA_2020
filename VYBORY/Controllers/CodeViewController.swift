//
//  CodViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CodeViewController: UICollectionViewController {
    
    
    //    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let db = Database()
    
    var books = [String]()
    var bookNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = db.getBooks()
        bookNames = db.getBooksName()
    }
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        bookCell.bookName.text = bookNames[indexPath.row]
        bookCell.bookNumber.text = books[indexPath.row]
        bookCell.bookImage.image = UIImage(named: "01_book_01_dark")
        
        
        return bookCell
    }
    
    
    
}

extension CodeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/2
        return CGSize(width: width,
               height: width)
    }
}

