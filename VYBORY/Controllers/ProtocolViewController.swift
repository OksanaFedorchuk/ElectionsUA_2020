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
            noResultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noResultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        noResultsView.noContImage.image = UIImage(named: "dog_1")
        noResultsView.noContLabel.text = "Протоколи в розробці"
    }


}

