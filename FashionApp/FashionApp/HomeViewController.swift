//
//  HomeViewController.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 05/04/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var centeredLabel: UILabel = {
       let label = UILabel()
        label.text = "HOME PAGE"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    private func setupLabel() {
        view.backgroundColor = .white
        view.addSubview(centeredLabel)
        centeredLabel.centerXYEqualTo(view)
    }
}
