//
//  VideoListPresenter.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation
import Alamofire
import RealmSwift

protocol VideoListProtocol {
    func showLoading()
    func showData()
    func showError(error: Error)
}

class VideoListPresenter {
    
    var favVideos: [Video] = []
    var videos: [Video] = []
    var view: VideoListProtocol?
    var addedToFav: (() -> Void)?
    
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
                self.getFavVideos()
            case .failure(let failure):
                print("Failed to fetch videos: \(failure.localizedDescription)")
                DispatchQueue.main.async {
                    self.view?.showError(error: failure)
                }
            }
        }
    }
    
    func getFavVideos() {
        favVideos.removeAll()
        
        let realm = try! Realm()
        let results = realm.objects(Video.self)
        self.favVideos = Array(results)
        self.view?.showData()
    }
    
    func addToFav(video: Video) {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(video)
                self.getFavVideos()
            }
        } catch {
            self.view?.showError(error: error)
        }
    }
    
    func removeFromFav(video: Video) {
        do {
            let realm = try Realm()
            if let videoToDelete = realm.object(ofType: Video.self, forPrimaryKey: video.id) {
                try realm.write {
                    realm.delete(videoToDelete)
                    self.getFavVideos()
                }
            }
        } catch {
            self.view?.showError(error: error)
        }
    }
    
    func checkIfVideoIsFavorited(video: Video) -> Bool {
        return favVideos.contains(where: { $0.id == video.id })
    }
}
