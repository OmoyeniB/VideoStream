//
//  AudioPlayerManager.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//

import Foundation
import AVFoundation
import AVKit
import UIKit

protocol AudioPlayerManagerDelegate: AnyObject {
    func audioPlayerError(error: Error)
}

final class AudioPlayerManager {
    
    weak var delegate: AudioPlayerManagerDelegate?
    var video: String?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoLooper: AVPlayerLooper?
    var avpController = AVPlayerViewController()
    
    func loadVideo(_ videoString: String, videoView: UIView) {
        if let url = URL(string: videoString) {
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            player = AVQueuePlayer(playerItem: item)
            videoLooper = AVPlayerLooper(player: player as! AVQueuePlayer, templateItem: item)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill
            playerLayer?.frame = videoView.bounds
            videoView.layer.addSublayer(playerLayer ?? AVPlayerLayer())
            player?.volume = 0
            playVideo()
        } else {
            delegate?.audioPlayerError(error: NetworkingError.invalidUrl)
        }
    }
    
    func playVideo() {
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
        }
    }
    
    func mute_unmute_Video(volume: Float) {
        player?.volume = volume
    }
    
}
