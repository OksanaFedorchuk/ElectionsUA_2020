//
//  CodeBookCell.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class CodeBookCell: UICollectionViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNumLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with bookName: String) {
        self.bookNumLabel.text = bookName
    }
}
