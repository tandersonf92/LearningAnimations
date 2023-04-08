//
//  OnboardingViewFactory.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Foundation

enum OnboardingViewFactory {
    static func build() -> OnboardingViewController {
        let slides = Slide.collection
        let navigationHandler = NavigationHandler()
        let loginService = LoginService()
        let collectionView = OnboardingCollectionView()
        let dataSource = OnboardingViewDataSource(slides: slides, collectionView: collectionView)
        let viewModel = OnboardingViewModel(dataSource: dataSource, loginService: loginService)
        let viewController = OnboardingViewController(navigationHandler: navigationHandler, viewModel: viewModel, collectionView: collectionView)
        viewModel.delegate = viewController
        dataSource.delegate = viewController
        
        return viewController
    }
}
