//
//  NavigationHandler.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol NavigationHandlerProtocol {
    func showMainPage()
    func showOnboardingPage()
}

final class NavigationHandler: NavigationHandlerProtocol {
    
    func showMainPage() {
        setRootViewController(with: HomeScreenViewController())
    }
    
    func showOnboardingPage() {
        setRootViewController(with: OnboardingViewFactory.build())
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
