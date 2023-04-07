//
//  OnboardingViewController.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                         collectionViewLayout: setupCollectionViewLayout())
    
    private let slides: [Slide] = Slide.collection
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
    }
    
    
    // MARK: Private Functions
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingViewCell.self, forCellWithReuseIdentifier: OnboardingViewCell.identifier)
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource,                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingViewCell.identifier, for: indexPath) as? OnboardingViewCell else {
            fatalError("Error creating the cell")
        }
        let slide = slides[indexPath.row]
        cell.configureCell(with: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth,
                      height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}

// MARK: ViewConfiguration
extension OnboardingViewController: ViewConfiguration {
    func configViews() {
        collectionView.backgroundColor = .white
    }
    
    func buildViews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.setAnchorsEqual(to: view)
    }
}

