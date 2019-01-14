//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by LiLi Kazine on 2019/1/14.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import UIKit

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 2.0
    var operation: UINavigationControllerOperation = .push
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    

    
}
