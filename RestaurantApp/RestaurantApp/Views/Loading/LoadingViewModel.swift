//
//  LoadingViewModel.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Foundation

protocol LoadingViewModelProtocol {
    func checkOnboardingStatus()
    var delegate: LoadingViewControllerDelegateProtocol? { get set }
}

struct LoadingViewModel: LoadingViewModelProtocol {
    
    private let loginService: LoginServiceProtocol
    
    weak var delegate: LoadingViewControllerDelegateProtocol?
    
    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }
    
    func checkOnboardingStatus() {
        let isOnboardingHaveSeen = loginService.isUserOnboardingSeen()
        
        if isOnboardingHaveSeen {
            delegate?.showHomePage()
        } else {
            delegate?.showOnboarding()
        }
    }
}
