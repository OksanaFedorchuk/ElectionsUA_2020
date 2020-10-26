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
    let minimumInteritemSpacing: CGFloat = 10
    
    var books = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            //            let book = books[indexPath.row]
            //            let book = "Book"
            //            bookCell.configure(with: book)
            bookCell.bookName.text = "Book Name"
            bookCell.bookNumber.text = "Book Number"
            
            bookCell.bookImage.image = UIImage(named: "01_book_01_dark")

        
        return bookCell
    }
    
    
    
}

extension CodeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width/2 - minimumInteritemSpacing,
               height: collectionView.bounds.size.height/2 - minimumInteritemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        minimumInteritemSpacing
    }
}

