//
//  HomeScreenViewController.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

final class HomeScreenViewController: UIViewController {
    
    // MARK: Properties
    private lazy var centeredLabel: UILabel = {
        let label = UILabel()
        label.text = "Home Screen"
        return label
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: ViewConfiguration
extension HomeScreenViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
    }
    
    func buildViews() {
        view.addSubview(centeredLabel)
    }
    
    func setupConstraints() {
        centeredLabel.centerXYEqualTo(view)
    }
}
