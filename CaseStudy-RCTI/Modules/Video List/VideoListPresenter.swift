//
//  VideoListPresenter.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import Alamofire

protocol VideoListProtocol {
    func showLoading()
    func showData()
    func showError(error: Error)
}

class VideoListPresenter {
    
    var videos: [Video] = []
    var view: VideoListProtocol?
    
    var fetchVideos: (@escaping (Result<[Video], Error>) -> Void) -> Void = { completion in
        let urlString = "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InvalidURL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
    
        AF.request(url).validate().responseDecodable(of: [Video].self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let videos):
                print("Successfully fetched videos")
                completion(.success(videos))
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func refresh() {
        self.view?.showLoading()
        videos.removeAll()
        fetchVideos { [unowned self] result in
            switch result {
            case .success(let fetchedVideos):
                self.videos = fetchedVideos
                DispatchQueue.main.async {
                    self.view?.showData()
                }
            case .failure(let failure):
                print("Failed to fetch videos: \(failure.localizedDescription)")
                DispatchQueue.main.async {
                    self.view?.showError(error: failure)
                }
            }
        }
    }
}
