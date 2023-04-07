//
//  OnboardingViewController.swift
//  RestaurantApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

protocol OnboardingViewControllerDelegateProtocol: AnyObject {
    func populateSlides(with slides: [Slide])
}

final class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    var viewModel: OnboardingViewModelProtocol
    
    private let navigationHandler: NavigationHandlerProtocol
    
    private var slides: [Slide] = []
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                         collectionViewLayout: setupCollectionViewLayout())
    
    private let dataSource: OnboardingViewDataSourceProtocol
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    // MARK: Life Cycle
    init(navigationHandler: NavigationHandlerProtocol = NavigationHandler(),
         dataSource: OnboardingViewDataSourceProtocol = OnboardingViewDataSource(slides: Slide.collection),
         viewModel: OnboardingViewModel) {
        self.navigationHandler = navigationHandler
        self.dataSource = dataSource
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.populateSlides()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupPageControl()
    }
    // MARK: scrollViewDidEndDecelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.y / scrollView.frame.size.height)
        print(index)
        pageControl.currentPage = index
    }
    
    
    // MARK: Private Functions
    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingViewCell.self, forCellWithReuseIdentifier: OnboardingViewCell.identifier)
        
        dataSource.handleActionButtonTap = self.handleActionButtonTap(at:)
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    private func handleActionButtonTap(at indexPath: IndexPath) {
        if indexPath.item == slides.count - 1 {
            navigationHandler.showMainPage()
        } else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            pageControl.currentPage = nextItem
        }
    }
    
    private func showHomeScreen() {
        navigationHandler.showMainPage()
    }
}

// MARK: OnboardingViewControllerDelegateProtocol
extension OnboardingViewController: OnboardingViewControllerDelegateProtocol {
    func populateSlides(with slides: [Slide]) {
        self.slides = slides
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
