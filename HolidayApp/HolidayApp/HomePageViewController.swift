//
//  HomePageViewController.swift
//  HolidayApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

final class HomePageViewController: UIViewController {
    // MARK: Properties
    private lazy var centeredLabel: UILabel = {
        let label = UILabel()
        label.text = "HomePage"
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension HomePageViewController: ViewConfiguration {
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
