//
//  FavoritListPresenter.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 27/06/24.
//

import Foundation
import RealmSwift

protocol FavoritListProtocol {
    func showLoading()
    func showData()
    func showError(error: Error)
}

class FavoritListPresenter {
    
    var favVideos: [Video] = []
    var view: FavoritListProtocol?
    
    func refresh() {
        self.view?.showLoading()
        favVideos.removeAll()
        
        let realm = try! Realm()
        let results = realm.objects(Video.self)
        self.favVideos = Array(results)
        self.view?.showData()
    }
    
    func removeFromFav(video: Video) {
        do {
            let realm = try Realm()
            if let videoToDelete = realm.object(ofType: Video.self, forPrimaryKey: video.id) {
                try realm.write {
                    realm.delete(videoToDelete)
                    refresh()
                }
            }
        } catch {
            self.view?.showError(error: error)
        }
    }
}
