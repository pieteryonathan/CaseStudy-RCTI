//
//  FavoritListController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import UIKit

class FavoritListController: UIViewController {

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
        label.text = "Favorite"
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
    
     public lazy var tableViewFavorit: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.backgroundColor = .white
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(EmptyStateCustom.self, forCellReuseIdentifier: "EmptyStateCustom")
        view.register(VideoListCell.self, forCellReuseIdentifier: "VideoListCell")
        return view
    }()
    
    // MARK: - VARIABLE DECLARATION
    var isLoading = true { didSet {
        setStateLoading()
    }}
    
    // MARK: - OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading = false
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        containerView.addArrangedSubViews(views: [stackViewHeader, viewLoading , tableViewFavorit])
        stackViewHeader.addArrangedSubViews(views: [labelHeader])
    }
    
    private func setStateLoading() {
        viewLoading.isHidden = !isLoading
        tableViewFavorit.isHidden = isLoading
    }
}

extension FavoritListController: UITableViewDataSource, UITableViewDelegate {
        
    func getEmptyStateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorit.dequeueReusableCell(withIdentifier: "EmptyStateCustom", for: indexPath) as! EmptyStateCustom
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        cell.setData(image: UIImage(named: "ils_empty_fav")!, title: "No Favorites Yet!", subTitle: "Add items to your favorites to see them in this list")
        cell.containerView.heightAnchor.constraint(equalToConstant: tableViewFavorit.frame.size.height).isActive = true
        return cell
    }
    
    func getVideoListCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFavorit.dequeueReusableCell(withIdentifier: "VideoListCell", for: indexPath) as! VideoListCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getVideoListCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude // removes weird extra padding
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
