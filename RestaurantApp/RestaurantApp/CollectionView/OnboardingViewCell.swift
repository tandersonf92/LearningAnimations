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
    
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST LABEL"
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) { nil }
    
}

extension OnboardingViewCell: ViewConfiguration {
    func configViews() {
        
    }
    
    func buildViews() {
        addSubview(containerView)
        containerView.addSubview(testLabel)
    }
    
    func setupConstraints() {
        containerView.setAnchorsEqual(to: self)
        testLabel.centerXYEqualTo(containerView)
    }
}
