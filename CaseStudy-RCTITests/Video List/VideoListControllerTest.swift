//
//  VideoListControllerTest.swift
//  CaseStudy-RCTITests
//
//  Created by Pieter Yonathan on 28/06/24.
//

import XCTest
@testable import CaseStudy_RCTI

class VideoListControllerTests: XCTestCase {
    
    var controller: VideoListController!
    
    override func setUp() {
        super.setUp()
        controller = VideoListController()
        // Load the view hierarchy explicitly since we are not using Storyboards
        controller.loadViewIfNeeded()
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // Given
        let presenter = MockVideoListPresenter()
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
        let tableView = controller.tableViewVideo
        let presenter = MockVideoListPresenter()
        controller.presenter = presenter
        
        // When
        controller.showData()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(tableView.numberOfRows(inSection: 0), presenter.videos.count, "Number of rows in table view should match presenter's videos count after showData")
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

// MockVideoListPresenter for testing purposes
class MockVideoListPresenter: VideoListPresenter {
    override func refresh() {
        // Simulate fetching data
        videos = [Video.mockVideo(), Video.mockVideo(), Video.mockVideo()] // Mock data for testing
        view?.showData()
    }
}
