//
//  DetailViewController.swift
//  Animations
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var barTitle = ""
    var animateView: UIView!
    
    fileprivate let duration = 2.0
    fileprivate let delay = 0.2
    fileprivate let scale: CGFloat = 1.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRect()
        setupNaviBar()
    }
    
    fileprivate func setupNaviBar() {
        navigationController?.navigationBar.topItem?.title = barTitle
    }
    
    fileprivate func setupRect() {
        if barTitle == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if barTitle == "View Fade In" {
            animateView = UIImageView(image: UIImage(named: "whatsapp"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else {
            animateView = drawRectView(UIColor.red, frame: generalFrame, center: generalCenter)
        }
        view.addSubview(animateView)
    }
    
    @IBAction func didTapAnimate(_ sender: AnyObject) {
        switch barTitle {
        case "2-Color":
            changeColor(UIColor.green)
            
        case "Simple 2D Rotation":
            rotateView(CGFloat.pi)
            
        case "Multicolor":
            multiColor(UIColor.green, UIColor.blue)
            
        case "Multi Point Position":
            multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100), CGPoint(x: animateView.frame.origin.x, y: 350))
            
        case "BezierCurve Position":
            var controlPoint1 = self.animateView.center
            controlPoint1.y -= 125.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0;
            var endPoint = self.animateView.center;
            endPoint.x += 75.0
            curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            
        case "Color and Frame Change":
            let currentFrame = self.animateView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orange, UIColor.yellow, UIColor.green)
            
        case "View Fade In":
            viewFadeIn()
            
        case "Pop":
            Pop()
            
        default:
            let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
        }
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

extension DetailViewController {
    
    fileprivate func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = color
        })
    }
    
    fileprivate func multiColor(_ first: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = first
        }, completion: { finished in
            self.changeColor(secondColor)
        })
    }
    
    
    fileprivate func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
        func simplePosition(_ pos: CGPoint) {
            UIView.animate(withDuration: duration) {
                self.animateView.frame.origin = pos
            }
        }
        UIView.animate(withDuration: duration, animations: {
            self.animateView.frame.origin = firstPos
        }) { (finished) in
            simplePosition(secondPos)
        }
    }
    
    fileprivate func rotateView(_ angel: CGFloat) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat], animations: {
            self.animateView.transform = CGAffineTransform(rotationAngle: angel)
        }, completion: nil)
    }
    
    fileprivate func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect, _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = firstColor
            self.animateView.frame = firstFrame
        }) { (fininshed) in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.backgroundColor = secondColor
                self.animateView.frame = secondFrame
            }) { (fininshed) in
                UIView.animate(withDuration: self.duration, animations: {
                    self.animateView.backgroundColor = thirdColor
                    self.animateView.frame = thirdFrame
                })
            }
        }
    }
    
    fileprivate func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.animateView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        anim.duration = duration
        self.animateView.layer.add(anim, forKey: "animate position along path")
        self.animateView.center = endPoint
    }
    
    fileprivate func viewFadeIn() {
        let sectionView = UIImageView(image: UIImage(named: "facebook"))
        sectionView.frame = self.animateView.frame
        sectionView.alpha = 0.0
        view.insertSubview(sectionView, aboveSubview: self.animateView)
        UIView.animate(withDuration: duration, delay: delay, animations: {
            sectionView.alpha = 1.0
            self.animateView.alpha = 0.0
        }, completion: nil)
    }
    
    fileprivate func Pop() {
        UIView.animate(withDuration: duration/4, animations: {
            self.animateView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
        }) { (finished) in
            UIView.animate(withDuration: self.duration/4, animations: {
                self.animateView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
}
