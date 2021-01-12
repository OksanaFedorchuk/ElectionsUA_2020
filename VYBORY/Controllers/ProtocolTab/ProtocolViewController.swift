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
            noResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105),
            noResultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
        
        noResultsView.noContImage.image = UIImage(named: "dog_1")
        noResultsView.noContLabel.text = "ПРОТОКОЛИ В РОЗРОБЦІ"
    }


}

