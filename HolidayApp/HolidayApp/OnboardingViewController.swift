//
//  OnboardingViewController.swift
//  HolidayApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import AVFoundation
import Combine
import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var internalContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "See what's happening this holiday season"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get started", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.addTarget(self, action: #selector(goToHomePage), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        buildViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAppEventSubscribers()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    // MARK: Selectors
    @objc private func goToHomePage() {
        print("OK")
        navigationController?.pushViewController(HomePageViewController(), animated: true)
    }
    
    // MARK: Private Functions
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "bg_holiday_video", ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let playerLayer = playerLayer,
           view.layer.sublayers?.contains(playerLayer) == false {
            view.layer.insertSublayer(playerLayer, at: 0)
        }
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func observeAppEvents() {
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { [weak self] _ in
                self?.restartVideo()
            }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self]_ in
            self?.pauseVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self]_ in
            self?.playVideo()
        }.store(in: &appEventSubscribers)
    }
    
    private func removeAppEventSubscribers() {
        appEventSubscribers.forEach { subscriber in
            subscriber.cancel()
        }
    }
}

// MARK: ViewConfiguration
extension OnboardingViewController: ViewConfiguration {
    
    func configViews() {
        view.backgroundColor = .clear
        contentView.backgroundColor = .init(white: 0.1, alpha: 0.5)
    }
    
    func buildViews() {
        view.addSubview(contentView)
        contentView.addSubview(internalContentStackView)
        [titleLabel, nextButton].forEach(internalContentStackView.addArrangedSubview)
        
        nextButton.layer.cornerRadius = 28
        nextButton.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        contentView.setAnchorsEqual(to: view)
        
        internalContentStackView.centerXYEqualTo(contentView)
        internalContentStackView.anchors(leadingReference: contentView.leadingAnchor,
                                         trailingReference: contentView.trailingAnchor,
                                         leftPadding: 36,
                                         rightPadding: 36)
        nextButton.size(height: 56)
    }
}
