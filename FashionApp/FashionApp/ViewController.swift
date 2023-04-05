//
//  ViewController.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//

import UIKit

final class ViewController: UIViewController {

    private let items: [OnboardingItem] = OnboardingItem.quoteItems
    
    private var imageViews: [UIImageView] = []
    
    // MARK: Properties
    private lazy var mainContentView: UIView = UIView()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .systemGroupedBackground
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .darkGray
        pageControl.numberOfPages = items.count
        return pageControl
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var cellContentView: UIView = UIView()
    
    private lazy var imageContentView: UIView = UIView()
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupImageViews()
        setupViews()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func setupImageViews() {
        items.forEach { item in
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleToFill
            imageContentView.addSubview(imageView)
            imageView.anchors(topReference: imageContentView.topAnchor,
                              leadingReference: imageContentView.leadingAnchor,
                              trailingReference: imageContentView.trailingAnchor,
                              bottomReference: imageContentView.bottomAnchor)
            
            imageView.alpha = 0
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1
        
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    private func updatePageControlPage(page index: Int) {
        pageControl.currentPage = index
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        pageControl.currentPage = index
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPosition = scrollView.contentOffset.x
        
        let index = getCurrentIndex()
        let fadeInAlpha = (xPosition - collectionviewWidth * CGFloat(index)) / collectionviewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        let canShow = (index < items.count - 1)
        if canShow {
            imageViews[index].alpha = fadeOutAlpha
            imageViews[index + 1].alpha = fadeInAlpha
        }
        
        if let lastImage = imageViews.last {
            let isNextButtonHidden = lastImage.alpha > 0.99
            mainButton.isHidden = isNextButtonHidden
            // trocar por GO TO MAIN PAGE
        }
    }
    
    var collectionviewWidth: CGFloat {
        collectionView.frame.size.width
    }
    
    @objc private func nextButtonClick() {
        let indexPath = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: indexPath, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        updatePageControlPage(page: indexPath)
    }
}

// MARK: Collection Delegate, need refactor to another file
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
            return cell
        }
        let isLastCell = indexPath.row == items.count - 1
        cell.updateCell(with: items[indexPath.row], isLastCell: isLastCell)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: CollectionViewDelegate
extension ViewController: CollectionViewDelegate {
    func goToMainPage() {
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = HomeViewController()
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil)
        }
    }
}

// MARK: ViewConfiguration
extension ViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
    }
    
    func buildViews() {
        view.addSubview(mainContentView)
        
        [mainButton, pageControl].forEach(mainContentView.addSubview)
        [imageContentView, cellContentView].forEach(mainContentView.addSubview)
        cellContentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        mainContentView.setAnchorsEqual(to: view)
        
        mainButton.anchors(topReference: mainContentView.safeAreaLayoutGuide.topAnchor,
                           trailingReference: mainContentView.trailingAnchor,
                           rightPadding: 16)
        
        pageControl.anchors(topReference: mainButton.bottomAnchor)
        pageControl.centerXEqualTo(mainContentView)
        
        collectionView.setAnchorsEqual(to: cellContentView)
        cellContentView.anchors(topReference: pageControl.bottomAnchor,
                                leadingReference: mainContentView.leadingAnchor,
                                trailingReference: mainContentView.trailingAnchor,
                                bottomReference: mainContentView.bottomAnchor)
        
        imageContentView.anchors(leadingReference: mainContentView.leadingAnchor,
                                 trailingReference: mainContentView.trailingAnchor,
                                 bottomReference: mainContentView.bottomAnchor)
        
        imageContentView.heightAnchor.constraint(equalTo: mainContentView.heightAnchor, multiplier: 0.70).isActive = true
    }
}
