//
//  OnboardingViewCell.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

final class OnboardingViewCell: UICollectionViewCell {
    // MARK: Properties
    static var identifier = "OnboardingViewCell"
    
    private lazy var containerView: UIView = UIView()
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var internalTopContentView: UIView = UIView()
    
    private lazy var internalBottomContentView: UIView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var mainButtonContentView: UIView = UIView()
    
    private lazy var mainButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 24)
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: Configuration cell function
    
    func configureCell(with slide: Slide) {
        titleLabel.text = slide.title
        mainButton.setTitle(slide.buttonTitle, for: .normal)
        mainButton.backgroundColor = slide.buttonColor
    }
}

extension OnboardingViewCell: ViewConfiguration {
    func configViews() {
        self.backgroundColor = .white
        internalTopContentView.backgroundColor = .green
    }
    
    func buildViews() {
        addSubview(containerView)
        containerView.addSubview(contentStackView)
        [internalTopContentView, internalBottomContentView, mainButtonContentView].forEach(contentStackView.addArrangedSubview)
        internalBottomContentView.addSubview(titleLabel)
        mainButtonContentView.addSubview(mainButton)
        
    }
    
    func setupConstraints() {
        containerView.setAnchorsEqual(to: self)
        contentStackView.anchors(leadingReference: containerView.leadingAnchor,
                                 trailingReference: containerView.trailingAnchor)
        contentStackView.centerYEqualTo(containerView)
        
        internalTopContentView.heightAnchor.constraint(equalTo: internalTopContentView.widthAnchor, multiplier: 1).isActive = true
        
        titleLabel.setAnchorsEqual(to: internalBottomContentView,
                                         padding: .init(top: 36,
                                                        left: 24,
                                                        bottom: 36,
                                                        right: 24))
        mainButton.setAnchorsEqual(to: mainButtonContentView, padding: .init(top: 0,
                                                                             left: 24,
                                                                             bottom: 0,
                                                                             right: 24))
        mainButton.size(height: 56)
    }
}
