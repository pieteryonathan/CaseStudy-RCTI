//
//  FavoritListPresenterTest.swift
//  CaseStudy-RCTITests
//
//  Created by Pieter Yonathan on 28/06/24.
//

import XCTest
@testable import CaseStudy_RCTI

class MockFavoritListView: FavoritListProtocol {
    var loadingCalled = false
    var dataCalled = false
    var errorReceived: Error?
    
    func showLoading() {
        loadingCalled = true
    }
    
    func showData() {
        dataCalled = true
    }
    
    func showError(error: Error) {
        errorReceived = error
    }
}

class FavoritListPresenterTest: XCTestCase {
    
    var presenter: VideoListPresenter!
    var mockView: MockFavoritListView!
    
    override func setUp() {
        super.setUp()
        presenter = VideoListPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
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
}
