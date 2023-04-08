//
//  LoadingViewModelTests.swift
//  RestaurantAppTests
//
//  Created by Anderson Oliveira on 08/04/23.
//

import XCTest
@testable import RestaurantApp

final class LoadingViewModelTests: XCTestCase {
    
    var loginService: LoginServiceProtocol?
    var viewModel: LoadingViewModelProtocol?
    var navigationHandler: NavigationHandlerProtocol?
    var sut: LoadingViewControllerSpy?

    override func tearDownWithError() throws {
        loginService = nil
        viewModel = nil
        navigationHandler = nil
        sut = nil
    }
    
    func test_whenOnboardingHaveSeenThenHomeScreenShouldBeCalled() throws {
        
        loginService = LoginServiceStub(isOnboardingSeen: true)
        let unwrappedLoginService = try XCTUnwrap(loginService)
        viewModel = LoadingViewModel(loginService: unwrappedLoginService)
        var unwrappedViewModel = try XCTUnwrap(viewModel)
        sut = LoadingViewControllerSpy(viewModel: unwrappedViewModel)
        let unwrappedSut = try XCTUnwrap(sut)
        unwrappedViewModel.delegate = unwrappedSut
        
        unwrappedViewModel.checkOnboardingStatus()
        
        XCTAssertTrue(unwrappedSut.showHomePageWasCalled)
        XCTAssertFalse(unwrappedSut.showOnboardingWasCalled)
    }
    
    func test_whenOnboardingHaveNotSeenThenOnboardingScreenShouldBeCalled() throws {
        
        loginService = LoginServiceStub(isOnboardingSeen: false)
        let unwrappedLoginService = try XCTUnwrap(loginService)
        viewModel = LoadingViewModel(loginService: unwrappedLoginService)
        var unwrappedViewModel = try XCTUnwrap(viewModel)
        sut = LoadingViewControllerSpy(viewModel: unwrappedViewModel)
        let unwrappedSut = try XCTUnwrap(sut)
        unwrappedViewModel.delegate = unwrappedSut
        
        unwrappedViewModel.checkOnboardingStatus()
        
        XCTAssertTrue(unwrappedSut.showOnboardingWasCalled)
        XCTAssertFalse(unwrappedSut.showHomePageWasCalled)
    }
}
