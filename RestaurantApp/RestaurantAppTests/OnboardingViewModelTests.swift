//
//  OnboardingViewModelTests.swift
//  RestaurantAppTests
//
//  Created by Anderson Oliveira on 08/04/23.
//

import XCTest
@testable import RestaurantApp

class OnboardingViewModelTests: XCTestCase {

    var slides: [Slide]?
    var navigationHandler: NavigationHandlerProtocol?
    var loginService: LoginServiceProtocol?
    var collectionView: OnboardingCollectionViewProtocol?
    var dataSource: OnboardingViewDataSourceProtocol?
    var viewModel: OnboardingViewModelProtocol?
    var sut: OnboardingViewControllerSpy?
    
    override func setUp() {
        slides = Slide.collection
        navigationHandler = NavigationHandler()
        loginService = LoginService()
        collectionView = OnboardingCollectionView()
        guard let slides = slides,
              let collectionView = collectionView,
              let loginService = loginService,
              let navigationHandler = navigationHandler else {
            return
        }

        dataSource = OnboardingViewDataSource(slides: slides, collectionView: collectionView)
        guard let dataSource = dataSource else { return }
        viewModel = OnboardingViewModel(dataSource: dataSource, loginService: loginService)
        guard var viewModel = viewModel else { return }
        sut = OnboardingViewControllerSpy(navigationHandler: navigationHandler, viewModel: viewModel, collectionView: collectionView)
        viewModel.delegate = sut
        dataSource.delegate = sut
    }

    override func tearDownWithError() throws {
        viewModel?.delegate = nil
        dataSource?.delegate = nil
        slides = nil
        navigationHandler = nil
        loginService = nil
        collectionView = nil
        dataSource = nil
        viewModel = nil
        sut = nil
    }
    
    func testWhenCallHandleActionButtonTapAndWeAreInTheLastPageThenTheUserShouldGoToMainPage() throws {
        let unwrappedViewModel = try XCTUnwrap(viewModel)
        let unwrappedSut = try XCTUnwrap(sut)
        
        unwrappedViewModel.handleActionButtonTap(at: IndexPath(item: 1, section: 0))
        
        XCTAssertTrue(unwrappedSut.goToMainWasCalled)
        XCTAssertFalse(unwrappedSut.goToNextSlideWasCalled)
    }
    
    func testWhenCallHandleActionButtonTapAndWeAreNotInTheLastPageThenShouldCallNextSlide() throws {
        let unwrappedViewModel = try XCTUnwrap(viewModel)
        let unwrappedSut = try XCTUnwrap(sut)
        
        unwrappedViewModel.handleActionButtonTap(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(unwrappedSut.goToNextSlideWasCalled)
        XCTAssertFalse(unwrappedSut.goToMainWasCalled)
    }
    
    func testWhenUpdatePageControlCurrantPageWasCalledThenPageControlSelectedPageNeedToBeUpdated() throws {
        let unwrappedViewModel = try XCTUnwrap(viewModel)
        let unwrappedSut = try XCTUnwrap(sut)
        let index = 1
        
        unwrappedViewModel.delegate?.updatePageControlCurrentPage(with: index)
        
        XCTAssertEqual(unwrappedSut.pageControlSelectedPage, index)
    }
}
