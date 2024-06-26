//
//  MainTabBarRCTIController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//
import Foundation
import UIKit

class MainTabBarRCTIController: MainTabBarController {
    
    // MARK: - Declaration Menu
    lazy var videoListController: VideoListController = {
        let controller = VideoListController()
        controller.tabBarItem = UITabBarItem(title: "Video", image: UIImage(systemName: "movieclapper"), tag: 0)
        if let image = UIImage(systemName: "movieclapper.fill") {
            let coloredImage = image.withTintColor(UIColor(named: "primary-color") ?? .blue)
            controller.tabBarItem.selectedImage = coloredImage
        }
        return controller
    }()
    
    lazy var favoritListController: FavoritListController = {
        let controller = FavoritListController()
        controller.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 2)
        if let image = UIImage(systemName: "heart.fill") {
            let coloredImage = image.withTintColor(UIColor(named: "primary-color") ?? .blue)
            controller.tabBarItem.selectedImage = coloredImage
        }
        return controller
    }()
    
   
    override func initialViewControllers() {
        viewControllers = [
            videoListController,
            favoritListController
        ]
    }
}
