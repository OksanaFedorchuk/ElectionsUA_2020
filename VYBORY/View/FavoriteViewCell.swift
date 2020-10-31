//
//  FavoriteViewCell.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 31.10.2020.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
