//
//  ViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

class ProtocolViewController: UIViewController {
    
    lazy var noResultsView = NoContentView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(noResultsView)
        noResultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noResultsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            noResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            noResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        noResultsView.noContImage.image = UIImage(named: "dog_1")
        noResultsView.noContLabel.text = "Протоколи в розробці"
    }


}

