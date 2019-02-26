
//
//  TickleGestureRecognizer.swift
//  MonkeyPinch
//
//  Created by LiLi Kazine on 2019/2/25.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class TickleGestureRecognizer: UIGestureRecognizer {
    
    let requiredTickles = 2
    let distanceForTickleGesture: CGFloat = 25.0
    
    enum Direction: Int {
        case DirectionUnknow = 0
        case DirectionLeft
        case DirectionRight
    }
    
    var tickleCount: Int = 0
    var curTickleStart: CGPoint = .zero
    var lastDirection: Direction = .DirectionUnknow
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            curTickleStart = touch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            let ticklePoint = touch.location(in: view)
            let moveAmt = ticklePoint.x - curTickleStart.x
            var curDirection: Direction
            if moveAmt < 0 {
                curDirection = .DirectionLeft
            } else {
                curDirection = .DirectionRight
            }
            
            if abs(moveAmt) < distanceForTickleGesture {
                return
            }
            
            if lastDirection == .DirectionUnknow ||
                (lastDirection == .DirectionLeft && curDirection == .DirectionRight) ||
                (lastDirection == .DirectionRight && curDirection == .DirectionLeft) {
                tickleCount += 1
                curTickleStart = ticklePoint
                lastDirection = curDirection
                if state == .possible && tickleCount > requiredTickles {
                    state = .ended
                }
            }
            
        }
    }
    
    override func reset() {
        tickleCount = 0
        curTickleStart = .zero
        lastDirection = .DirectionUnknow
        if state == .possible {
            state = .failed
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    

}
