//
//  TransitionManager.swift
//  Tumblr
//
//  Created by LiLi Kazine on 2018/12/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        let screens: (from: UIViewController, to: UIViewController) = (transitionContext.viewController(forKey: .from)!, transitionContext.viewController(forKey: .to)!)
        
        let menuVC = !presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomVC = !presenting ? screens.to as!  UIViewController : screens.from as! UIViewController
        let menuView = menuVC.view
        let bottomView = bottomVC.view
        if presenting {
            offStageMenu(menuVC)
        }
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            if self.presenting {
                self.onStageMenu(menuVC)
            } else {
                self.offStageMenu(menuVC)
            }
        }) { (finished) in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
        }
    }
    
    func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenu(_ menu: MenuViewController) {
        menu.view.alpha = 0.0
        
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menu.textPostIcon.transform = self.offStage(-topRowOffset)
        menu.textPostLabel.transform = self.offStage(-topRowOffset)
        
        menu.quotePostIcon.transform = self.offStage(-middleRowOffset)
        menu.quotePostLabel.transform = self.offStage(-middleRowOffset)
        
        menu.chatPostIcon.transform = self.offStage(-bottomRowOffset)
        menu.chatPostLabel.transform = self.offStage(-bottomRowOffset)
        
        menu.photoPostIcon.transform = self.offStage(topRowOffset)
        menu.photoPostLabel.transform = self.offStage(topRowOffset)
        
        menu.linkPostIcon.transform = self.offStage(middleRowOffset)
        menu.linkPostLabel.transform = self.offStage(middleRowOffset)
        
        menu.audioPostIcon.transform = self.offStage(bottomRowOffset)
        menu.audioPostLabel.transform = self.offStage(bottomRowOffset)
        
    }
    
    func onStageMenu(_ menu: MenuViewController) {
        menu.view.alpha = 1.0
        
        menu.textPostIcon.transform = CGAffineTransform.identity
        menu.textPostLabel.transform = CGAffineTransform.identity
        
        menu.quotePostIcon.transform = CGAffineTransform.identity
        menu.quotePostLabel.transform = CGAffineTransform.identity
        
        menu.chatPostIcon.transform = CGAffineTransform.identity
        menu.chatPostLabel.transform = CGAffineTransform.identity
        
        menu.photoPostIcon.transform = CGAffineTransform.identity
        menu.photoPostLabel.transform = CGAffineTransform.identity
        
        menu.linkPostIcon.transform = CGAffineTransform.identity
        menu.linkPostLabel.transform = CGAffineTransform.identity
        
        menu.audioPostIcon.transform = CGAffineTransform.identity
        menu.audioPostLabel.transform = CGAffineTransform.identity
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
}
