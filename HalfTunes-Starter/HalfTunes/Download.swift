//
//  Download.swift
//  HalfTunes
//
//  Created by LiLi Kazine on 2019/2/14.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation

class Download {

  var track: Track
  init(track: Track) {
    self.track = track
  }
  
  var task: URLSessionDownloadTask?
  var isDownloading = false
  var resumeData: Data?
  
  var progress:Float = 0
  
  
  
  

}
