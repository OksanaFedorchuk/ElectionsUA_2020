//
//  NoContentView.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 30.11.2020.
//

import UIKit

class NoContentView: UIView {

    @IBOutlet weak var noContImage: UIImageView!
    @IBOutlet weak var noContLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibInit()
    }
    
    func xibInit() {
        let viewFromXib = Bundle.main.loadNibNamed("NoContentView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}
