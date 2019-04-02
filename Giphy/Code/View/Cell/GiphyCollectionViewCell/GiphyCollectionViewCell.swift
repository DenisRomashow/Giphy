//
//  GiphyCollectionViewCell.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import UIKit
import AVKit

class GiphyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    deinit {
        removeVideoPlayer()
    }

    func setupMoviePlayer(url: URL?) {
        activityIndicator.startAnimating()

        guard let url = url else { return }
        let item = AVPlayerItem(url: url)

        avPlayer = AVPlayer(playerItem: item)
        avPlayer?.volume = 0
        avPlayer?.actionAtItemEnd = .none

        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        avPlayerLayer?.frame = self.bounds

        videoView.layer.insertSublayer(avPlayerLayer!, at: 0)
        videoView.backgroundColor = .clear
        videoView.layer.masksToBounds = true

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer?.currentItem)
    }

    func removeVideoPlayer() {
        stopPlayback()
        activityIndicator.stopAnimating()
        avPlayerLayer?.removeFromSuperlayer()
        NotificationCenter.default.removeObserver(self)
    }

    func stopPlayback() {
        self.avPlayer?.pause()
    }

    func startPlayback() {
        self.avPlayer?.play()

    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero)
    }
}
