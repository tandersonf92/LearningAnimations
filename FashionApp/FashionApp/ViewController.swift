//
//  ViewController.swift
//  FashionApp
//
//  Created by Anderson Oliveira on 02/04/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let items: [OnboardingItem] = OnboardingItem.quoteItems
    
    // MARK: Properties
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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    private func updatePageControlPage(page index: Int) {
        pageControl.currentPage = index
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
            return cell }
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
    }
    
    func buildViews() {
        [mainButton, pageControl, containerView].forEach(view.addSubview)
        containerView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        mainButton.anchors(topReference: view.safeAreaLayoutGuide.topAnchor,
                           trailingReference: view.trailingAnchor,
                           rightPadding: 16)
        
        pageControl.anchors(topReference: mainButton.bottomAnchor)
        pageControl.centerXEqualTo(view)
        
        containerView.anchors(topReference: pageControl.bottomAnchor,
                              leadingReference: view.leadingAnchor,
                              trailingReference: view.trailingAnchor,
                              bottomReference: view.bottomAnchor)
        
        collectionView.setAnchorsEqual(to: containerView)
    }
}
