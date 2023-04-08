//
//  OnboardingViewCell.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Lottie
import UIKit

final class OnboardingViewCell: UICollectionViewCell {
    // MARK: Properties
    static var identifier = "OnboardingViewCell"
    
    var actionButtonDidTap: (() -> Void)?
    
    private lazy var containerView: UIView = UIView()
    
    private lazy var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var animationContentView: UIView = UIView()
    
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
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainButton.layer.cornerRadius = 8
    }
    
    // MARK: Selectors
    @objc private func actionButtonTapped() {
        actionButtonDidTap?()
    }
    
    // MARK: Cell configuration function
    func configureCell(with slide: Slide) {
        titleLabel.text = slide.title
        mainButton.setTitle(slide.buttonTitle, for: .normal)
        mainButton.backgroundColor = slide.buttonColor
        createLottionAnimationView(with: slide.animationName)
    }
    
    // MARK: Create and setup animation
    private func createLottionAnimationView(with animationName: String) {
        let lottieAnimation = LottieAnimationView(name: animationName)
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
        setupLottieAnimation(lottieAnimation: lottieAnimation)
    }
    
    private func setupLottieAnimation(lottieAnimation: LottieAnimationView) {
        animationContentView.addSubview(lottieAnimation)
        lottieAnimation.setAnchorsEqual(to: animationContentView)
    }
}

// MARK: ViewConfiguration
extension OnboardingViewCell: ViewConfiguration {
    func configViews() {
    }
    
    func buildViews() {
        addSubview(containerView)
        containerView.addSubview(contentStackView)
        [animationContentView, internalBottomContentView, mainButtonContentView].forEach(contentStackView.addArrangedSubview)
        internalBottomContentView.addSubview(titleLabel)
        mainButtonContentView.addSubview(mainButton)
        
    }
    
    func setupConstraints() {
        containerView.setAnchorsEqual(to: self)
        contentStackView.anchors(leadingReference: containerView.leadingAnchor,
                                 trailingReference: containerView.trailingAnchor)
        contentStackView.centerYEqualTo(containerView)
        
        animationContentView.heightAnchor.constraint(equalTo: animationContentView.widthAnchor, multiplier: 1).isActive = true
        
        titleLabel.setAnchorsEqual(to: internalBottomContentView,
                                         padding: .init(top: 32,
                                                        left: 24,
                                                        bottom: 16,
                                                        right: 24))
        mainButton.setAnchorsEqual(to: mainButtonContentView, padding: .init(top: 0,
                                                                             left: 24,
                                                                             bottom: 0,
                                                                             right: 24))
        mainButton.size(height: 56)
    }
}
