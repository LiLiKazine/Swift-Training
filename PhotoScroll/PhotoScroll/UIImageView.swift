//
//  UIImageView.swift
//  PhotoScroll
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

extension UIImage {
    func thumbnailOfSize(_ size: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}
