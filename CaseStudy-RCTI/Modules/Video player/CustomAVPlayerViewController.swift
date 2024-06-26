//
//  CustomAVPlayerViewController.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 27/06/24.
//

import Foundation
import AVKit
import AVFoundation

class CustomAVPlayerViewController: AVPlayerViewController {

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        player?.pause()
//        player?.replaceCurrentItem(with: nil)
//        player = nil
    }
}
