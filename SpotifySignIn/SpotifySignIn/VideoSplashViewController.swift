//
//  VideoSplashViewController.swift
//  SpotifySignIn
//
//  Created by LiLi Kazine on 2018/12/19.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashViewController: UIViewController {
    
    fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel: Float = 1.0
    
    open var contentURL: URL? {
        didSet{
            setMoviePlayer(contentURL!)
        }
    }
    
    open var videoFrame: CGRect = CGRect()
    open var startTime: CGFloat = 0.0
    open var duration: CGFloat = 0.0
    open var backgroundColor: UIColor = UIColor.black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    open var sound: Bool = true {
        didSet {
            if sound {
                moviePlayerSoundLevel = 1.0
            } else {
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    open var alpha: CGFloat = CGFloat() {
        didSet{
            moviePlayer.view.alpha = alpha
        }
    }
    open var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: moviePlayer.player?.currentItem)
            }
        }
    }
    open var fillMode: ScalingMode = .resizeAspectFill {
        didSet {
            switch fillMode {
            case .resize:
                moviePlayer.videoGravity = .resize
            case .resizeAspect:
                moviePlayer.videoGravity = .resizeAspect
            case .resizeAspectFill:
                moviePlayer.videoGravity = .resizeAspectFill
            }
        }
    }
    
    func setMoviePlayer(_ url: URL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (path, err) in
            if let path = path {
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        self.moviePlayer.player = AVPlayer(url: path)
                        self.moviePlayer.player?.play()
                        self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func playerItemDidReachEnd() {
        moviePlayer.player?.seek(to: CMTime.zero)
        moviePlayer.player?.play()
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }

}
