//
//  VideCutter.swift
//  SpotifySignIn
//
//  Created by LiLi Kazine on 2018/12/19.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var convert: NSString {
        return (self as NSString)
    }
}

class VideoCutter: NSObject {

    open func cropVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion: ((_ videoPath: URL?, _ error: Error?) -> Void)?) {
        DispatchQueue.global().async {
            let asset = AVURLAsset(url: url)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            var outputURL: String = path[0]
            let manager = FileManager.default
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
                
            }
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            do {
                try manager.removeItem(atPath: outputURL)
            } catch _ {
                
            }
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = .mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
                let range = CMTimeRangeMake(start: start, duration: duration)
                exportSession.timeRange = range
                if let cb = completion {
                    exportSession.exportAsynchronously {
                        switch exportSession.status {
                        case .completed:
                            cb(exportSession.outputURL, nil)
                        case .failed:
                            print("Failed: \(String(describing: exportSession.error))")
                        case .cancelled:
                            print("Failed: \(String(describing: exportSession.error))")
                        default:
                            print("default case")
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                
            }
        }
            
    }
    

}
