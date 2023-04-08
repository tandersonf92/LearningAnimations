//
//  OnboardingCollecitonView.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 08/04/23.
//

import UIKit

protocol OnboardingCollectionViewProtocol: UICollectionView {
    
}

final class OnboardingCollectionView: UICollectionView, OnboardingCollectionViewProtocol {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    
    private func setupCollectionView() {
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
        self.register(OnboardingViewCell.self, forCellWithReuseIdentifier: OnboardingViewCell.identifier)
    }
}
