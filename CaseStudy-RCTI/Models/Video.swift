//
//  Video.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation

struct VideoResponse: Codable {
    let videos: [Video]
}

struct Video: Codable {
    let id: String?
    let title: String?
    let thumbnailURL: String?
    let duration: String?
    let uploadTime: String?
    let views: String?
    let author: String?
    var videoURL: String?
    let description, subscriber: String?
    let isLive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case description, subscriber, isLive
    }
    
    mutating func convertHTTPToHTTPS() {
        if var videoURL = self.videoURL, videoURL.lowercased().hasPrefix("http://") {
            videoURL.replaceSubrange(videoURL.startIndex..<videoURL.index(videoURL.startIndex, offsetBy: 4), with: "https")
            self.videoURL = videoURL
        }
    }
}
