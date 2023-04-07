//
//  LoginService.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import Foundation

protocol LoginServiceProtocol {
    func isUserOnboardingSeen() -> Bool
    func setOnboardingSeen()
    func resetOnboardingSeen()
}


struct LoginService: LoginServiceProtocol {
    private enum OnboardingKey: String {
        case onboardingSeen
    }
    
    func isUserOnboardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: OnboardingKey.onboardingSeen.rawValue)
    }
    
    func setOnboardingSeen() {
        UserDefaults.standard.set(false, forKey: OnboardingKey.onboardingSeen.rawValue)
    }
    
    func resetOnboardingSeen() {
        UserDefaults.standard.set(false, forKey: OnboardingKey.onboardingSeen.rawValue)
    }
}
