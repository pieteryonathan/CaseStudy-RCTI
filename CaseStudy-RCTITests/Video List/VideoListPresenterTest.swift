//
//  VideoListPresenterTest.swift
//  CaseStudy-RCTITests
//
//  Created by Pieter Yonathan on 28/06/24.
//

import XCTest
@testable import CaseStudy_RCTI

extension Video {
    static var idCounter = 0
    
    static func mockVideo(title: String = "Mock Video", thumbnailURL: String? = "https://mockthumbnail.com/thumbnail", duration: String? = "10:00", uploadTime: String? = "2023-01-01", views: String? = "1000", author: String? = "Mock Author", videoURL: String? = "http://mockvideo.com/video", videoDescription: String? = "This is a mock video.", subscriber: String? = "5000", isLive: Bool? = false) -> Video {
        
        let video = Video()
        video.id = "\(UUID().uuidString)-\(idCounter)"
        idCounter += 1
        
        video.title = title
        video.thumbnailURL = thumbnailURL
        video.duration = duration
        video.uploadTime = uploadTime
        video.views = views
        video.author = author
        video.videoURL = videoURL
        video.videoDescription = videoDescription
        video.subscriber = subscriber
        video.isLive = isLive
        
        return video
    }
}

class VideoListPresenterTests: XCTestCase {
    
    var presenter: VideoListPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = VideoListPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testAddToFavorites() {
        // Remove existing mock video from favorites (if any)
        presenter.removeFromFav(video: Video.mockVideo())
        
        // Given
        let videoToAdd = Video.mockVideo()
        
        // When
        presenter.addToFav(video: videoToAdd)
        
        // Then
        XCTAssertTrue(presenter.checkIfVideoIsFavorited(video: videoToAdd))
    }
    
    func testRemoveFromFavorites() {
        // Given
        let videoToAdd = Video.mockVideo()
        
        // Add video to favorites
        presenter.addToFav(video: videoToAdd)
        
        // Capture initial favVideos count
        let initialCount = presenter.favVideos.count
        
        // When
        presenter.removeFromFav(video: videoToAdd)
        
        // Then
        XCTAssertEqual(presenter.favVideos.count, initialCount - 1, "FavVideos count should decrease by 1 after removal")
    }
    
    func testCheckIfVideoIsFavorited() {
        // Given
        let videoToAdd = Video.mockVideo()
        
        // When
        presenter.addToFav(video: videoToAdd)
        
        // Then
        XCTAssertTrue(presenter.checkIfVideoIsFavorited(video: videoToAdd))
    }
}
