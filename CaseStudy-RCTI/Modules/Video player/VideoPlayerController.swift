//
//  VideoPlayerController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 27/06/24.
//

import UIKit
import AVFoundation
import AVKit
import RealmSwift

class VideoPlayerController: UIViewController {
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .zero
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    private lazy var viewPlayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 184).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackViewScroll: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        return view
    }()
    
    private lazy var stackViewContent: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = video.title ?? ""
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var stackViewInfo: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private lazy var labelViews: UILabel = {
        let label = UILabel()
        label.text = "\(video.views?.formattedViews() ?? "") views"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var labelUpload: UILabel = {
        let label = UILabel()
        label.text = video.uploadTime ?? ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var stackViewAuthor: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4
        return view
    }()
    
    private lazy var labelAuthor: UILabel = {
        let label = UILabel()
        label.text = video.author ?? ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var labelSubs: UILabel = {
        let label = UILabel()
        label.text = video.subscriber?.formattedSubscribers() ?? ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var stackViewDesc: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        return view
    }()
    
    private lazy var containerViewDesc: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 8
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        return view
    }()
    
    private lazy var labelTitleDesc: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var labelDesc: UILabel = {
        let label = UILabel()
        label.text = video.videoDescription ?? ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private func getDot() -> UILabel {
        let label = UILabel()
        label.text = "•"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }
    
    // MARK: - VARIABLE DECLARATION
        var video: Video
        private var player: AVPlayer?
        private var playerViewController: AVPlayerViewController?
        
        lazy var activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            return indicator
        }()
        
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
            setupPlayer()
        }
        
        // MARK: - SETUP
        
        private func setupPlayer() {
            video.convertHTTPToHTTPS()
            guard let videoURL = URL(string: video.videoURL ?? "") else { return }
            player = AVPlayer(url: videoURL)
            playerViewController = AVPlayerViewController()
            playerViewController?.player = player
            playerViewController?.delegate = self
            
            addChild(playerViewController!)
            viewPlayer.addSubview(playerViewController!.view)
            playerViewController!.view.frame = viewPlayer.bounds
            playerViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                playerViewController!.view.leadingAnchor.constraint(equalTo: viewPlayer.leadingAnchor),
                playerViewController!.view.trailingAnchor.constraint(equalTo: viewPlayer.trailingAnchor),
                playerViewController!.view.topAnchor.constraint(equalTo: viewPlayer.topAnchor),
                playerViewController!.view.bottomAnchor.constraint(equalTo: viewPlayer.bottomAnchor)
            ])
            playerViewController!.didMove(toParent: self)
            
            viewPlayer.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: viewPlayer.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: viewPlayer.centerYAnchor)
            ])
            
            player?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
            player?.currentItem?.addObserver(self, forKeyPath: "isPlaybackLikelyToKeepUp", options: [.new, .initial], context: nil)
            
            player?.play()
        }
        
        private func setupView() {
            containerView.addArrangedSubViews(views: [viewPlayer, scrollView, StackViewHelpers.getSpacerV()])
            stackViewScroll.addArrangedSubViews(views: [stackViewContent, stackViewDesc, StackViewHelpers.getSpacerV()])
            
            stackViewContent.addArrangedSubViews(views: [labelTitle, stackViewInfo, stackViewAuthor])
            stackViewContent.setCustomSpacing(8, after: labelTitle)
            stackViewInfo.addArrangedSubViews(views: [labelViews, labelUpload, StackViewHelpers.getSpacerH()])
            
            stackViewAuthor.addArrangedSubViews(views: [labelAuthor, getDot(), labelSubs, StackViewHelpers.getSpacerH()])
            
            stackViewDesc.addArrangedSubViews(views: [containerViewDesc])
            containerViewDesc.addArrangedSubViews(views: [labelTitleDesc, labelDesc])
        }
    
        // MARK: - OBSERVER METHOD
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            guard let player = player else { return }
            
            switch keyPath {
            case "status":
                if player.status == .readyToPlay {
                    activityIndicator.stopAnimating()
                } else if player.status == .failed {
                    activityIndicator.stopAnimating()
                }
                
            case "isPlaybackLikelyToKeepUp":
                if player.currentItem?.isPlaybackLikelyToKeepUp == true {
                    activityIndicator.stopAnimating()
                } else {
                    activityIndicator.startAnimating()
                }
                
            default:
                break
            }
        }
        
        // MARK: - DEINIT
        
        deinit {
            player?.removeObserver(self, forKeyPath: "status")
            player?.currentItem?.removeObserver(self, forKeyPath: "isPlaybackLikelyToKeepUp")
        }
    }

    extension VideoPlayerController: AVPlayerViewControllerDelegate {
        func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            
        }
    }
