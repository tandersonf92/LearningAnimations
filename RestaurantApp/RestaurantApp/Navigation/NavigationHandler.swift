//
//  NavigationHandler.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol NavitationHandlerProtocol {
    func showMainPage()
    func showOnboardingPage()
}

final class NavitationHandler: NavitationHandlerProtocol {
    
    func showMainPage() {
        setRootViewController(with: HomeScreenViewController())
    }
    
    func showOnboardingPage() {
        setRootViewController(with: OnboardingViewController())
    }
    
    private func setRootViewController(with viewController: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = viewController
            
            UIView.transition(with: window,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: nil)
        }
    }
}
