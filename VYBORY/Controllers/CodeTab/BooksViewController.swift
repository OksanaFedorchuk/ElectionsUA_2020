//
//  CodViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class BooksViewController: UICollectionViewController {
    
    @IBAction func infoBarButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: K.Identifiers.Segue.GoToAboutUs, sender: Any.self)
    }
    
    let db = BookEntity()
    
    var books = [Book]()
    var selectedBook = Book(number: "", title: "")
    
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
        
        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Identifiers.Cell.BookCell, for: indexPath) as! BookCell
        
        bookCell.bookNumber.text = books[indexPath.row].number
        bookCell.bookTitle.text = books[indexPath.row].title
        bookCell.bookImage.image = UIImage(named: K.Image.BookImages[indexPath.row])
        
        return bookCell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ChaptersViewController {
            destinationVC.navigationItem.title = selectedBook.number
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedBook = books[indexPath.row]
        self.performSegue(withIdentifier: K.Identifiers.Segue.GoToChapter, sender: Any.self)
    }
}


// MARK: - FlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/2
        return CGSize(width: width,
                      height: width)
    }
}

