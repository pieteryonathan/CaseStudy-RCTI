//
//  VideoListCell.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import UIKit

class VideoListCell: UITableViewCell {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 16, left: 0, bottom: 16, right: 0)
        return view
    }()

    private lazy var stackViewContent: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    private lazy var imageViewThumb: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(hexString: "#124076")?.withAlphaComponent(0.5) ?? .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 184).isActive = true
        return imageView
    }()
    
    private lazy var favBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }()
    
    private lazy var imageViewFav: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var durationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.7)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelDuration: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = "15:00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Title Video"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var stackViewInfo: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private lazy var labelAuthor: UILabel = {
        let label = UILabel()
        label.text = "Author Video"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var labelViews: UILabel = {
        let label = UILabel()
        label.text = "510k views"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var labelUpload: UILabel = {
        let label = UILabel()
        label.text = "2 months ago"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
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
    var shimmeringAnimatedItems: [UIView] {
            [
                imageViewThumb,
                labelDuration,
                labelTitle,
                labelAuthor,
                labelUpload,
                labelViews
            ]
        }

    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    // MARK: - SETUP

    private func setupView() {
        backgroundColor = .clear
 
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: containerView, toView: contentView)
        containerView.addArrangedSubview(stackViewContent)
        stackViewContent.addArrangedSubViews(views: [imageViewThumb, labelTitle, stackViewInfo])
        stackViewInfo.addArrangedSubViews(views: [labelAuthor, getDot(), labelViews, getDot(), labelUpload, StackViewHelpers.getSpacerH()])
        stackViewContent.setCustomSpacing(4, after: labelTitle)
        
        imageViewThumb.addSubview(durationBackgroundView)
        imageViewThumb.addSubview(favBackgroundView)
        favBackgroundView.addSubview(imageViewFav)
        durationBackgroundView.addSubview(labelDuration)
 
        NSLayoutConstraint.activate([
            
            favBackgroundView.trailingAnchor.constraint(equalTo: imageViewThumb.trailingAnchor, constant: -8),
            favBackgroundView.topAnchor.constraint(equalTo: imageViewThumb.topAnchor, constant: 8),
            
            imageViewFav.centerXAnchor.constraint(equalTo: favBackgroundView.centerXAnchor),
            imageViewFav.centerYAnchor.constraint(equalTo: favBackgroundView.centerYAnchor),
            
            durationBackgroundView.trailingAnchor.constraint(equalTo: imageViewThumb.trailingAnchor, constant: -8),
            durationBackgroundView.bottomAnchor.constraint(equalTo: imageViewThumb.bottomAnchor, constant: -8),
            durationBackgroundView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            durationBackgroundView.heightAnchor.constraint(equalToConstant: 20),
            
            labelDuration.centerXAnchor.constraint(equalTo: durationBackgroundView.centerXAnchor),
            labelDuration.centerYAnchor.constraint(equalTo: durationBackgroundView.centerYAnchor),
            labelDuration.leadingAnchor.constraint(equalTo: durationBackgroundView.leadingAnchor, constant: 4),
            labelDuration.trailingAnchor.constraint(equalTo: durationBackgroundView.trailingAnchor, constant: -4)
        ])
    }
    
    public func setData(video: Video) {
        imageViewThumb.afImage(video.thumbnailURL ?? "", placeholder: UIImage(named: "placeholder_video"))
        labelTitle.text = video.title ?? ""
        labelAuthor.text = video.author ?? ""
        labelViews.text = video.views?.formattedViews() ?? ""
        labelUpload.text = video.uploadTime ?? ""
        labelDuration.text = video.duration
    }
}
