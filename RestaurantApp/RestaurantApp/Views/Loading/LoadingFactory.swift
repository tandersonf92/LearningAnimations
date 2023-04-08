//
//  LoadingFactory.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

enum LoadingFactory {
    static func build() -> LoadingViewController {
        let loginService = LoginService()
        let viewModel = LoadingViewModel(loginService: loginService)
        let navigationHandler = NavigationHandler()
        let viewController = LoadingViewController(viewModel: viewModel, navigationHandler: navigationHandler)
        
        return viewController
    }
}
