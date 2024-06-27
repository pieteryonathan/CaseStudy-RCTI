//
//  Video.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import RealmSwift

struct VideoResponse: Codable {
    let videos: [Video]
}

class Video: Object, Codable {
    @Persisted var id: String?
    @Persisted var title: String?
    @Persisted var thumbnailURL: String?
    @Persisted var duration: String?
    @Persisted var uploadTime: String?
    @Persisted var views: String?
    @Persisted var author: String?
    @Persisted var videoURL: String?
    @Persisted var videoDescription: String?
    @Persisted var subscriber: String?
    @Persisted var isLive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case videoDescription = "description"
        case subscriber, isLive
    }
    
    func convertHTTPToHTTPS() {
        if var videoURL = self.videoURL, videoURL.lowercased().hasPrefix("http://") {
            videoURL.replaceSubrange(videoURL.startIndex..<videoURL.index(videoURL.startIndex, offsetBy: 4), with: "https")
            self.videoURL = videoURL
        }
    }
}
