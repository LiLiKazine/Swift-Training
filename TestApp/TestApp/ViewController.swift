//
//  ViewController.swift
//  TestApp
//
//  Created by LiLi Kazine on 2019/1/25.
//  Copyright © 2019 LiLi Kazine. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    @IBAction func pushBtn(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0.0)
        
        let savedContentOffset = scrollView.contentOffset
        let savedFrame = scrollView.frame
        
        scrollView.contentOffset = CGPoint.zero
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        scrollView.contentOffset = savedContentOffset
        scrollView.frame = savedFrame
        
        UIGraphicsEndImageContext()
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image!)
        }) { (isSuccess: Bool, error: Error?) in
            DispatchQueue.main.async { [weak self] in
                self?.showSaveAlbumAlert(isSuccess: isSuccess, err: error)
            }
            if !isSuccess {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func showSaveAlbumAlert(isSuccess: Bool, err: Error?) {
        // Request authorization
        let title = isSuccess ? "Succeeded" : "Failed"
        let tip = isSuccess ? "Successfully Saved Photo to Album." : err?.localizedDescription
        let alertController = UIAlertController(title: title,
                                                message: tip, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            print("OK")
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

