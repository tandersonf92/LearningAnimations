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
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.backgroundColor = .blue
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
            imageView.clipsToBounds = true
            imageContentView.addSubview(imageView)
            
            //            imageView.heightAnchor.constraint(equalTo: imageContentView.heightAnchor, multiplier: 0.3).isActive = true // problema ta na altura, inestigar
            //                        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
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
        let fadeInAlpha = (xPosition - collectionviewWidht * CGFloat(index)) / collectionviewWidht
        //        print("fadeInAlpha = \(fadeInAlpha)")
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        
        let canShow = (index < items.count - 1)
        
        if canShow {
            imageViews[index].alpha = fadeOutAlpha
            imageViews[index + 1].alpha = fadeInAlpha
        }
    }
    
    var collectionviewWidht: CGFloat {
        collectionView.frame.size.width
    }
    
    @objc private func nextButtonClick() {
        let indexPath = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: indexPath, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        updatePageControlPage(page: indexPath)
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
            return cell
        }
        cell.updateCell(with: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: ViewConfiguration
extension ViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
        imageContentView.backgroundColor = .orange
    }
    
    func buildViews() {
        view.addSubview(mainContentView)
        
        [mainButton, pageControl].forEach(mainContentView.addSubview)
        
        [cellContentView, imageContentView].forEach(mainContentView.addSubview)
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
        
        imageContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        cellContentView.anchors(topReference: pageControl.bottomAnchor,
                                leadingReference: mainContentView.leadingAnchor,
                                trailingReference: mainContentView.trailingAnchor)
        
        imageContentView.anchors(topReference: cellContentView.bottomAnchor,
                                 leadingReference: mainContentView.leadingAnchor,
                                 trailingReference: mainContentView.trailingAnchor,
                                 bottomReference: mainContentView.bottomAnchor)
    }
}
