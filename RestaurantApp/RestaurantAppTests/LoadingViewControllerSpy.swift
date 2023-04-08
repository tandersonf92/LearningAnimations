//
//  LoadingViewControllerSpy.swift
//  RestaurantAppTests
//
//  Created by Anderson Oliveira on 08/04/23.
//

import UIKit
@testable import RestaurantApp

final class LoadingViewControllerSpy: LoadingViewControllerDelegateProtocol {

    // MARK: Properties
    private var viewModel: LoadingViewModelProtocol
    
    var showOnboardingWasCalled = false
    var showHomePageWasCalled = false
    
    // MARK: Life Cycle
    init(viewModel: LoadingViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    func showOnboarding() {
        showOnboardingWasCalled = true
    }
    
    func showHomePage() {
        showHomePageWasCalled = true
    }
}
