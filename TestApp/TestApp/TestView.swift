//
//  TestView.swift
//  TestApp
//
//  Created by LiLi Kazine on 2019/1/25.
//  Copyright © 2019 LiLi Kazine. All rights reserved.
//

import UIKit

class TestView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalIn: rect)
        UIColor.gray.setFill()
        path.fill()
    }

}
