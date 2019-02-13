//
//  PushButton.swift
//  Flo
//
//  Created by LiLi Kazine on 2019/1/23.
//  Copyright © 2019 LiLi Kazine. All rights reserved.
//

import UIKit

@IBDesignable
class PushButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = true

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth/2
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        plusPath.move(to: CGPoint(x: halfWidth-halfPlusWidth+Constants.halfPointShift, y: halfHeight+Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(x: halfWidth+halfPlusWidth+Constants.halfPointShift, y: halfHeight+Constants.halfPointShift))
        UIColor.white.setStroke()
        plusPath.stroke()
        if isAddButton {
            plusPath.move(to: CGPoint(x: halfWidth+Constants.halfPointShift, y: halfHeight-halfPlusWidth+Constants.halfPointShift))
            plusPath.addLine(to: CGPoint(x: halfWidth+Constants.halfPointShift, y: halfHeight+halfPlusWidth+Constants.halfPointShift))
            plusPath.stroke()
        }
        
    }
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }

}
