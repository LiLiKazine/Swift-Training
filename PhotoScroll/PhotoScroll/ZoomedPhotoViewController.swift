//
//  ZoomedPhotoViewController.swift
//  PhotoScroll
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ZoomedPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var photoName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: photoName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScale(forSize: view.bounds.size)
        
    }
    
    fileprivate func updateConstraints(forSize size: CGSize) {
        let yOffset = max(0, (size.height-imageView.frame.height)/2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width-imageView.frame.width)/2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        view.layoutIfNeeded()
    }
    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width/imageView.bounds.width
        let heightScale = size.height/imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZoomedPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(forSize: view.bounds.size)
    }
}
