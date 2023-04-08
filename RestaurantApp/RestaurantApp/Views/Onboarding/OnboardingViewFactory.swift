//
//  OnboardingViewFactory.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Foundation

enum OnboardingViewFactory {
    static func build() -> OnboardingViewController { // adicionar a collectionView e jogar como dependencia na controller. //scrollDidAcelerating nao funcionando pq n tem referencia dela, e ela e chamada no delegate, que esta no datasource
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
