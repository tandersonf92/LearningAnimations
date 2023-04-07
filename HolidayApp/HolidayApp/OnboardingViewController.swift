//
//  OnboardingViewController.swift
//  HolidayApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    private lazy var contentView: UIView = UIView()
    
    private lazy var internalContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "See what's happening this holiday season"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get started", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        buildViews()
        setupConstraints()
    }
    
    // MARK: Selectors
    // MARK: Private Functions
}

// MARK: ViewConfiguration
extension OnboardingViewController: ViewConfiguration {
    
    func configViews() {
        view.backgroundColor = .darkGray
    }
    
    func buildViews() {
        view.addSubview(contentView)
        contentView.addSubview(internalContentStackView)
        [titleLabel, nextButton].forEach(internalContentStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        contentView.setAnchorsEqual(to: view)
        
        internalContentStackView.centerXYEqualTo(contentView)
        internalContentStackView.anchors(leadingReference: contentView.leadingAnchor,
                                         trailingReference: contentView.trailingAnchor,
                                         leftPadding: 36,
                                         rightPadding: 36)
        
        nextButton.size(height: 56)
    }
}
