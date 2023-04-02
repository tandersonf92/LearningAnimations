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
        return stackView
    }()
    
    private lazy var topContainerView: UIView = UIView()
    
    private lazy var labelsContainerStackView: UIStackView = {
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
    
    private lazy var bottomContainerView: UIView = UIView()
    
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
    func configViews() {
        topContainerView.backgroundColor = .blue
        bottomContainerView.backgroundColor = .orange
    }
    
    func buildViews() {
        addSubview(contentStackView)
        [topContainerView, bottomContainerView].forEach(contentStackView.addArrangedSubview)
        topContainerView.addSubview(labelsContainerStackView)
        [titleLabel, descriptionLabel, bottomSpacerView].forEach(labelsContainerStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        contentStackView.setAnchorsEqual(to: self)
        
        labelsContainerStackView.setAnchorsEqual(to: topContainerView, padding: .init(top: 8,
                                                                                       left: 8,
                                                                                       bottom: 8,
                                                                                       right: 8))
        
        
        bottomContainerView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 4).isActive = true
    }
}
