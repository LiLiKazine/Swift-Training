/*
* Copyright (c) 2014-present Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var penguin: UIImageView!
  @IBOutlet var slideButton: UIButton!
  
    var isLookingRight: Bool = true {
        didSet {
            let scaleX: CGFloat = isLookingRight ? 1 : -1
            penguin.transform = CGAffineTransform(scaleX: scaleX, y: 1)
            slideButton.transform = penguin.transform
        }
    }
  var penguinY: CGFloat = 0.0
  
  var walkSize: CGSize = CGSize.zero
    
  var slideSize: CGSize = CGSize.zero
  
  let animationDuration = 1.0
  
  var walkFrames = [
    UIImage(named: "walk01.png")!,
    UIImage(named: "walk02.png")!,
    UIImage(named: "walk03.png")!,
    UIImage(named: "walk04.png")!
  ]
  
  var slideFrames = [
    UIImage(named: "slide01.png")!,
    UIImage(named: "slide02.png")!,
    UIImage(named: "slide01.png")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //grab the sizes of the different sequences
    walkSize = walkFrames[0].size
    print(walkSize)
    slideSize = slideFrames[0].size
    
    //setup the animation
    penguinY = penguin.frame.origin.y
    
    loadWalkAnimation()
  }
  
  func loadWalkAnimation() {
    penguin.animationImages = walkFrames
    penguin.animationDuration = animationDuration / 3
    penguin.animationRepeatCount = 3
  }
  
  func loadSlideAnimation() {
    penguin.animationImages = slideFrames
    penguin.animationDuration = animationDuration
    penguin.animationRepeatCount = 1
  }
  
  @IBAction func actionLeft(_ sender: AnyObject) {
    isLookingRight = false
    penguin.startAnimating()
    UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
        self.penguin.center.x -= self.walkSize.width
    }, completion: nil)
  }
  
  @IBAction func actionRight(_ sender: AnyObject) {
    isLookingRight = true
    penguin.startAnimating()
    UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
        self.penguin.center.x += self.walkSize.width
    }, completion: nil)
  }
  
  @IBAction func actionSlide(_ sender: AnyObject) {
    loadSlideAnimation()
    penguin.frame = CGRect(x: penguin.frame.origin.x, y: penguinY, width: slideSize.width, height: slideSize.height)
    penguin.startAnimating()
    UIView.animate(withDuration: animationDuration - 0.02, delay: 0.0, options: .curveEaseOut, animations: {
        self.penguin.center.x += self.isLookingRight ? self.slideSize.width : -self.slideSize.width
    }) { _ in
        self.penguin.frame = CGRect(x: self.penguin.frame.origin.x, y: self.penguinY, width: self.walkSize.width, height: self.walkSize.height)
        self.loadWalkAnimation()
    }
  }
}

