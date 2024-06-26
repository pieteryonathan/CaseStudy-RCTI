//
//  VideoPlayerController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 27/06/24.
//

import UIKit
import AVFoundation
import AVKit

protocol VideoPlayerControllerDelegate: AnyObject {
    func videoPlayerControllerDidDismiss()
}

class VideoPlayerController: UIViewController {
    
    weak var delegate: VideoPlayerControllerDelegate?
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    private lazy var viewPlayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 184).isActive = true
        return view
    }()
    
    // MARK: - VARIABLE DECLARATION
    var video: Video
    private var player: AVPlayer?
    private var playerViewController: AVPlayerViewController?
    
    // MARK: - INIT
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        
        video.convertHTTPToHTTPS()
        let videoURL = URL(string: video.videoURL ?? "")!
        player = AVPlayer(url: videoURL)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        playerViewController?.delegate = self // Set the delegate
        
        // Add AVPlayerViewController as a child view controller
        addChild(playerViewController!)
        viewPlayer.addSubview(playerViewController!.view)
        playerViewController?.delegate = self
        playerViewController!.view.frame = viewPlayer.bounds
        playerViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController!.view.leadingAnchor.constraint(equalTo: viewPlayer.leadingAnchor),
            playerViewController!.view.trailingAnchor.constraint(equalTo: viewPlayer.trailingAnchor),
            playerViewController!.view.topAnchor.constraint(equalTo: viewPlayer.topAnchor),
            playerViewController!.view.bottomAnchor.constraint(equalTo: viewPlayer.bottomAnchor)
        ])
        playerViewController!.didMove(toParent: self)
        
        // Start playing the video
        player?.play()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubview(viewPlayer)
        containerView.addArrangedSubview(StackViewHelpers.getSpacerV())
    }
    
    // MARK: - DISMISS PLAYER
    
    func dismissPlayer() {
        // Pause the player
        player?.pause()
        
        // Remove observers if any
        
        // Remove AVPlayerViewController from parent
        playerViewController?.willMove(toParent: nil)
        playerViewController?.view.removeFromSuperview()
        playerViewController?.removeFromParent()
        
        // Nil out player and playerViewController
        player = nil
        playerViewController = nil
        
        // Notify delegate
        delegate?.videoPlayerControllerDidDismiss()
    }
}

extension VideoPlayerController: AVPlayerViewControllerDelegate {
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: any UIViewControllerTransitionCoordinator) {
        self.popOrDismiss()
        dismissPlayer()
    }
}
