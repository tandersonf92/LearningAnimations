//
//  OnboardingViewModel.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Foundation
import UIKit

protocol OnboardingViewModelProtocol {
    var delegate: OnboardingViewControllerDelegateProtocol? { get set }
    
    func populateSlides()
    func getSlidesNumber() -> Int
}

struct OnboardingViewModel: OnboardingViewModelProtocol {
    
    private let dataSource: OnboardingViewDataSourceProtocol
    
    weak var delegate: OnboardingViewControllerDelegateProtocol? {
        didSet {
            populateSlides()
        }
    }
    
    func populateSlides() {
        delegate?.populateSlides(with: dataSource.getSlides)
    }
    
    func getSlidesNumber() -> Int  {
        dataSource.getSlides.count
    }
    
    init(dataSource: OnboardingViewDataSourceProtocol) {
        self.dataSource = dataSource
    }
}
