//
//  ViewController.swift
//  SpotifySignIn
//
//  Created by LiLi Kazine on 2018/12/19.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
    }
    
    func setupVideoBackground() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)

//        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.isUserInteractionEnabled = false
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

