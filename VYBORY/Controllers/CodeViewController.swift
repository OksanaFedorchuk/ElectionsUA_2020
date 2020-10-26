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

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
//            let book = books[indexPath.row]
//            let book = "Book"
//            bookCell.configure(with: book)
            bookCell.bookName.text = "Book Name"
            bookCell.bookNumber.text = "Book Number"
        
        bookCell.bookImage.image = UIImage(named: "01_book_01_dark")
            
            cell = bookCell
        
        }
        return cell
    }

}

//extension CodeViewController: UICollectionViewDelegateFlowLayout {
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
////           return CGSize(width: 250, height: 250)
//
//        return CGSize(width: collectionView.bounds.size.width/2 - 10, height: collectionView.bounds.size.height/2 - 10)
//    }
//}

