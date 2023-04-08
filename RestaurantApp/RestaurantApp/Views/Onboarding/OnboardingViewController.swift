//
//  OnboardingViewController.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol OnboardingViewControllerDelegateProtocol: AnyObject {
    func goToNextSlide(at indexPath: IndexPath)
    func goToMainPage()
    func updatePageControlCurrentPage(with index: Int)
}

final class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: OnboardingViewModelProtocol
    
    private let navigationHandler: NavigationHandlerProtocol
    
    private var collectionView: OnboardingCollectionViewProtocol
    
    private var dataSource: OnboardingViewDataSourceProtocol?
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    // MARK: Life Cycle
    init(navigationHandler: NavigationHandlerProtocol, viewModel: OnboardingViewModelProtocol, collectionView: OnboardingCollectionViewProtocol) {
        self.navigationHandler = navigationHandler
        self.viewModel = viewModel
        self.collectionView = collectionView
        super.init(nibName: nil, bundle: nil)
        self.dataSource = viewModel.getDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPageControl()
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.getSlidesNumber()
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
    }
}

// MARK: OnboardingViewControllerDelegateProtocol
extension OnboardingViewController: OnboardingViewControllerDelegateProtocol {
    func goToNextSlide(at indexPath: IndexPath) {
        let nextItem = indexPath.item + 1
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
        pageControl.currentPage = nextItem
    }
    
    func goToMainPage() {
        navigationHandler.showMainPage()
    }
    
    func updatePageControlCurrentPage(with index: Int) {
        pageControl.currentPage = index
    }
}

// MARK: ViewConfiguration
extension OnboardingViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
    }
    
    func buildViews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    }
    
    func setupConstraints() {
        collectionView.setAnchorsEqual(to: view)
        
        pageControl.anchors(topReference: view.safeAreaLayoutGuide.topAnchor,
                            trailingReference: view.trailingAnchor,
                            topPadding: 8)
    }
}
