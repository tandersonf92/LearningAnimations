//
//  CollectionViewCell.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "CollectionViewCell"
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 20) // fazer demiBold
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 14) // fazer regular
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bottomSpacerView: UIView = UIView()
    
    private lazy var exploreButton: UIButton = {
        let button = UIButton()
        button.setTitle("EXPLORE", for: .normal)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func updateCell(with item: OnboardingItem) {
        titleLabel.text = item.author
        descriptionLabel.text = item.quote
    }
}

extension CollectionViewCell: ViewConfiguration {
    func configViews() { }
    
    func buildViews() {
        addSubview(contentStackView)
        [titleLabel, descriptionLabel, bottomSpacerView].forEach(contentStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        contentStackView.setAnchorsEqual(to: self, padding: .init(top: 8,
                                                                          left: 8,
                                                                          bottom: 8,
                                                                          right: 8))

//        exploreButton.anchors(leadingReference: bottomContainerView.leadingAnchor,
//                              trailingReference: bottomContainerView.trailingAnchor,
//                              bottomReference: bottomContainerView.bottomAnchor,
//                              leftPadding: 24,
//                              rightPadding: 24,
//                              bottomPadding: 24)
    }
}
