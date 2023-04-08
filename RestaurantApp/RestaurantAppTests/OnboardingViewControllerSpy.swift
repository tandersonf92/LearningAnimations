//
//  OnboardingViewControllerSpy.swift
//  RestaurantAppTests
//
//  Created by Anderson Oliveira on 08/04/23.
//

import Foundation

@testable import RestaurantApp

final class OnboardingViewControllerSpy: OnboardingViewControllerDelegateProtocol {

    private let viewModel: OnboardingViewModelProtocol
    private let navigationHandler: NavigationHandlerProtocol
    private let collectionView: OnboardingCollectionViewProtocol
    
    var goToNextSlideWasCalled: Bool = false
    var goToMainWasCalled: Bool = false
    var pageControlSelectedPage: Int?
    
    // MARK: Life Cycle
    init(navigationHandler: NavigationHandlerProtocol, viewModel: OnboardingViewModelProtocol, collectionView: OnboardingCollectionViewProtocol) {
        self.navigationHandler = navigationHandler
        self.viewModel = viewModel
        self.collectionView = collectionView
    }
    
    func goToNextSlide(at indexPath: IndexPath) {
        goToNextSlideWasCalled = true
    }
    
    func goToMainPage() {
        goToMainWasCalled = true
    }
    
    func updatePageControlCurrentPage(with index: Int) {
        pageControlSelectedPage = index
    }
}
