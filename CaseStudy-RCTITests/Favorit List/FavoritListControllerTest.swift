//
//  FavoritListControllerTest.swift
//  CaseStudy-RCTITests
//
//  Created by Pieter Yonathan on 28/06/24.
//

import XCTest
@testable import CaseStudy_RCTI

class FavoritListControllerTests: XCTestCase {
    
    var controller: FavoritListController!
    
    override func setUp() {
        super.setUp()
        controller = FavoritListController()
        // Load the view hierarchy explicitly since we are not using Storyboards
        controller.loadViewIfNeeded()
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // Given
        let presenter = MockFavoritListPresenter()
        controller.presenter = presenter
        
        // When
        controller.viewDidLoad()
        
        // Then
        XCTAssertFalse(controller.isLoading, "isLoading should be false after viewDidLoad")
    }
    
    func testShowLoading() {
        // Given
        controller.isLoading = false
        
        // When
        controller.showLoading()
        
        // Then
        XCTAssertTrue(controller.isLoading, "isLoading should be true after showLoading")
    }
    
    func testShowData() {
        // Given
        let presenter = MockFavoritListPresenter()
        controller.presenter = presenter
        
        // When
        controller.showData()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.controller.tableViewFavorit.numberOfRows(inSection: 0), presenter.favVideos.count, "Number of rows in table view should match presenter's favVideos count after showData")
        }
    }
    
    func testShowError() {
        // Given
        let mockError = NSError(domain: "TestError", code: 500, userInfo: nil)
        
        // When
        controller.showError(error: mockError)
        
        // Then
        XCTAssertFalse(controller.isLoading, "isLoading should be false after showError")
        // Additional assertions based on your error handling logic in showError
    }
}

// MockFavoritListPresenter for testing purposes
class MockFavoritListPresenter: FavoritListPresenter {
    override func refresh() {
        // Simulate fetching data
        favVideos = [Video.mockVideo(), Video.mockVideo(), Video.mockVideo()] // Mock data for testing
        view?.showData()
    }
}
