//
//  OnboardingViewModel.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol OnboardingViewModelProtocol {
    var delegate: OnboardingViewControllerDelegateProtocol? { get set }
    func getDataSource() -> OnboardingViewDataSourceProtocol
    func getSlidesNumber() -> Int
    func handleActionButtonTap(at indexPath: IndexPath)
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    private let dataSource: OnboardingViewDataSourceProtocol
    private let loginService: LoginServiceProtocol
    
    weak var delegate: OnboardingViewControllerDelegateProtocol?
    
    init(dataSource: OnboardingViewDataSourceProtocol, loginService: LoginServiceProtocol) {
        self.dataSource = dataSource
        self.loginService = loginService
        configureDataSource()
    }
    
    func getSlidesNumber() -> Int  {
        dataSource.getNumberOfSlides
    }
    
    func getDataSource() -> OnboardingViewDataSourceProtocol {
        return dataSource
    }
    
    func handleActionButtonTap(at indexPath: IndexPath) {
        let numberOfSlides = dataSource.getNumberOfSlides
        
        if indexPath.item == numberOfSlides - 1 {
            loginService.setOnboardingSeen()
            delegate?.goToMainPage()
        } else {
            delegate?.goToNextSlide(at: indexPath)
        }
    }
    
    private func configureDataSource() {
        dataSource.handleActionButtonTap = self.handleActionButtonTap(at:)
    }
}
