//
//  VideoListController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import UIKit
import FittedSheets

class VideoListController: UIViewController {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 24, bottom: 0, right: 24)
        self.view.addSubview(view)
        NSLayoutConstraint.pinToSafeArea(view, toView: self.view)
        return view
    }()
    
    private lazy var stackViewHeader: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 24, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = "Video List"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    public lazy var viewLoading: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    public lazy var tableViewVideo: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(VideoListCell.self, forCellReuseIdentifier: "VideoListCell")
        view.register(EmptyStateCustom.self, forCellReuseIdentifier: "EmptyStateCustom")
        return view
    }()
    
    // MARK: - VARIABLE DECLARATION
    var isLoading = true { didSet {
        setStateLoading()
    }}
    let presenter = VideoListPresenter()
    
    // MARK: - OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading = false
        view.backgroundColor = .white
        setupView()
        presenter.view = self
        presenter.refresh()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [stackViewHeader, viewLoading , tableViewVideo])
        stackViewHeader.addArrangedSubViews(views: [labelHeader])
    }
    
    private func setStateLoading() {
        viewLoading.isHidden = !isLoading
        tableViewVideo.isHidden = isLoading
    }
}

extension VideoListController: UITableViewDataSource, UITableViewDelegate {
        
    func getEmptyStateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewVideo.dequeueReusableCell(withIdentifier: "EmptyStateCustom", for: indexPath) as! EmptyStateCustom
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.setData(image: UIImage(named: "ils_empty_box")!, title: "Oops, No Videos Found!", subTitle: "It looks like there are no videos available right now.\nPlease check back later.")
        cell.containerView.heightAnchor.constraint(equalToConstant: tableViewVideo.frame.size.height).isActive = true
        return cell
    }
    
    func getVideoListCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewVideo.dequeueReusableCell(withIdentifier: "VideoListCell", for: indexPath) as! VideoListCell
        cell.selectionStyle = .none
        cell.setData(video: presenter.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getVideoListCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = VideoPlayerController(video: presenter.videos[indexPath.row])
        SheetViewController.show(controller, onParent: self, sizes: [.fullscreen])
        
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension VideoListController: VideoListProtocol {
    func showLoading() {
        isLoading = true
    }
    
    func showData() {
        self.isLoading = false
        tableViewVideo.reloadData()
    }
    
    func showError(error: any Error) {
        self.isLoading = false
        print(error.localizedDescription)
    }
}
