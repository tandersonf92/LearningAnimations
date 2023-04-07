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
        let dataSource = OnboardingViewDataSource(slides: slides)
        var viewModel = OnboardingViewModel(dataSource: dataSource)
        let viewController = OnboardingViewController(dataSource: dataSource, viewModel: viewModel)
        viewController.viewModel = viewModel
        viewModel.delegate = viewController
        
        return viewController
        
        //        OnboardingViewController(dataSource: OnboardingViewDataSource(slides: Slide.collection))
    }
}
