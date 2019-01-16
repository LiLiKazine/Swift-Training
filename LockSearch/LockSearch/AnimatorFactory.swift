//
//  AnimatorFactory.swift
//  Widgets
//
//  Created by LiLi Kazine on 2019/1/16.
//  Copyright © 2019 Underplot ltd. All rights reserved.
//

import UIKit

class AnimatorFactory {
  
  static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
    let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
    scale.addAnimations {
      view.alpha = 1.0
    }
    scale.addAnimations({
      view.transform = CGAffineTransform.identity
    }, delayFactor: 0.33)
    scale.addCompletion { _ in
      print("ready")
    }
    return scale
  }
  
  static func jiggle(view: UIView) -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.33, delay: 0, animations: {
      UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
          view.transform = CGAffineTransform(rotationAngle: -.pi/8)
        }
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
          view.transform = CGAffineTransform(rotationAngle: .pi/8)
        })
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1.0, animations: {
          view.transform = .identity
        })
      
      }, completion: { _ in
        view.transform = .identity
      })
    })
  }
  
  static func blur(view: UIView, blur: Bool) ->UIViewPropertyAnimator {
    
    return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
      view.alpha = blur ? 1 : 0
    }, completion: nil)
    
  }
  
  static func animateConstraint(view: UIView, constraint: NSLayoutConstraint, by: CGFloat) -> UIViewPropertyAnimator {
    let spring = UISpringTimingParameters(dampingRatio: 0.55)
    let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: spring)
    animator.addAnimations {
      constraint.constant += by
      view.layoutIfNeeded()
    }
    return animator
  }
  
}
