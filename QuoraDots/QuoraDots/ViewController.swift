//
//  ViewController.swift
//  QuoraDots
//
//  Created by LiLi Kazine on 2018/12/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var dotOne: UIImageView!
    @IBOutlet weak var dotTwo: UIImageView!
    @IBOutlet weak var dotThree: UIImageView!
    
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnim()
        doMask()
    }
    
    func startAnim() {
        dotOne.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotTwo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotThree.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.dotOne.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.dotTwo.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.dotThree.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    
    var imageView: UIImageView?
    var mask: CALayer?

    func doMask() {

//        imageView = UIImageView(frame: view.frame)
//        imageView?.image = UIImage(named: "twitterScreen")
//        view.addSubview(imageView!)
        
        mask = CALayer()
        mask?.contents = UIImage(named: "twitterBird")?.cgImage
        mask?.position = view.center
        mask?.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        container.layer.mask = mask
        view.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
        animateMask()
        
        
    }
    
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1.0
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        
        let initialBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 64))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        keyFrameAnimation.values = [initialBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut), CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        mask!.add(keyFrameAnimation, forKey: "bounds")
        
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        container.layer.mask = nil
    }

}

