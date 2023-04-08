//
//  LoadingViewController.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol LoadingViewControllerDelegateProtocol: AnyObject {
    func showOnboarding()
    func showHomePage()
}

final class LoadingViewController: UIViewController {
    
    // MARK: Properties
    private var viewModel: LoadingViewModelProtocol
    private let navigationHandler: NavigationHandlerProtocol
    
    // MARK: Life Cycle
    init(viewModel: LoadingViewModelProtocol, navigationHandler: NavigationHandlerProtocol) {
        self.viewModel = viewModel
        self.navigationHandler = navigationHandler
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.checkOnboardingStatus()
    }
}

// MARK: LoadingViewControllerDelegateProtocol
extension LoadingViewController: LoadingViewControllerDelegateProtocol {
    func showOnboarding() {
        navigationHandler.showOnboardingPage()
    }
    
    func showHomePage() {
        navigationHandler.showMainPage()
    }
}
