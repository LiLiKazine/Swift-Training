
//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by LiLi Kazine on 2019/1/14.
//  Copyright © 2019 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
       
        let herbView = presenting ? toView : transitionContext.view(forKey: .from)!
        let herbVC = presenting ? transitionContext.viewController(forKey: .to) as! HerbDetailsViewController : transitionContext.viewController(forKey: .from) as! HerbDetailsViewController
        
        let initailFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        let xScaleFactor = presenting ? initailFrame.width / finalFrame.width : finalFrame.width / initailFrame.width
        let yScaleFactor = presenting ? initailFrame.height / finalFrame.height : finalFrame.height / initailFrame.height
        
        let scaleTransfrom = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        var alpha: CGFloat = 0.0
        
        if presenting {
            alpha = 1.0
            herbVC.containerView.alpha = 0.0

            herbView.transform = scaleTransfrom
            herbView.center = CGPoint(x: initailFrame.midX, y: initailFrame.midY)
            herbView.clipsToBounds = true
        }
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        
        let radius = CABasicAnimation(keyPath: "cornerRadius")
        radius.fromValue = presenting ? 20.0/xScaleFactor : 0.0
        radius.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        radius.duration =  duration / 2
        radius.isRemovedOnCompletion = false
        radius.fillMode = kCAFillModeForwards
        herbView.layer.add(radius, forKey: nil)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, animations: {
            herbView.transform = self.presenting ?
                CGAffineTransform.identity :
            scaleTransfrom
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            herbVC.containerView.alpha = alpha
//            herbView.layer.cornerRadius = self.presenting ? 0.0 : 20.0/xScaleFactor
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
        
        
    }
    

    
}
