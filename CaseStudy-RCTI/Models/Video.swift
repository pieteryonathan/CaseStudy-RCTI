//
//  Video.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation

struct Video: Codable {
    let id: String?
    let title: String?
    let thumbnailURL: String?
    let duration: String?
    let uploadTime: String?
    let views: String?
    let author: String?
    let videoURL: String?
    let description, subscriber: String?
    let isLive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case description, subscriber, isLive
    }
}
