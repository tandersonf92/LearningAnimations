//
//  OnboardingViewDataSource.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol OnboardingViewDataSourceProtocol: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var getSlides: [Slide] { get }
    var handleActionButtonTap: ((IndexPath) -> Void)? { get set }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
}

final class OnboardingViewDataSource: NSObject, UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, OnboardingViewDataSourceProtocol {
    
    private let slides: [Slide]
    
    var handleActionButtonTap: ((IndexPath) -> Void)?
    
    var getSlides: [Slide] {
        slides
    }
    
    init(slides: [Slide]) {
        self.slides = slides
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingViewCell.identifier, for: indexPath) as? OnboardingViewCell else {
            fatalError("Error creating/casting the cell")
        }
        
        let slide = slides[indexPath.row]
        cell.configureCell(with: slide)
        cell.actionButtonDidTap = { [weak self] in
            guard let self = self,
                  let handleActionButtonTap = self.handleActionButtonTap else { return }
            
            handleActionButtonTap(indexPath)
        }
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
