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

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

func tintBackgroundColor(layer: CALayer, toColor: UIColor) {
    let color = CABasicAnimation(keyPath: "backgroundColor")
    color.fromValue = layer.backgroundColor
    color.toValue = toColor
    color.duration = 1.0
    layer.add(color, forKey: nil)
    layer.backgroundColor = toColor.cgColor
}

func roundCorners(layer: CALayer, toRadius: CGFloat) {
    let radius = CABasicAnimation(keyPath: "cornerRadius")
    radius.fromValue = layer.cornerRadius
    radius.toValue = toRadius
    radius.duration = 0.33
    layer.add(radius, forKey: nil)
    layer.cornerRadius = toRadius
}

class ViewController: UIViewController {

  // MARK: IB outlets

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!

  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!

  // MARK: further UI

  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
    let info = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]

  var statusPosition = CGPoint.zero

  // MARK: view controller methods

  override func viewDidLoad() {
    super.viewDidLoad()

    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true

    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)

    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)

    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)

    statusPosition = status.center
    
    info.frame = CGRect(x: 0.0, y: loginButton.center.y + 60.0, width: view.bounds.width, height: 30)
    info.backgroundColor = .clear
    info.font = UIFont(name: "HelveticaNeue", size: 12.0)
    info.textAlignment = .center
    info.textColor = .white
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: loginButton)
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let form = CAAnimationGroup()
    form.fillMode = kCAFillModeBoth
    form.duration = 0.5
    form.delegate = self
    form.setValue("form", forKey: "name")

    let opacity = CABasicAnimation(keyPath: "opacity")
    opacity.fromValue = 0.2
    opacity.toValue = 1.0
    
    let flyRight = CABasicAnimation(keyPath: "position.x")
    flyRight.fromValue = -view.bounds.width/2
    flyRight.toValue = view.bounds.width/2

    form.animations = [opacity, flyRight]
    
    form.setValue(heading.layer, forKey: "layer")
    heading.layer.add(form, forKey: nil)
    form.beginTime = CACurrentMediaTime() + 0.3
    form.setValue(username.layer, forKey: "layer")
    username.layer.add(form, forKey: nil)
    form.beginTime = CACurrentMediaTime() + 0.4
    form.setValue(password.layer, forKey: "layer")
    password.layer.add(form, forKey: nil)
    

  
    
    let alpha = CABasicAnimation(keyPath: "opacity")
    alpha.fromValue = 0.0
    alpha.toValue = 1.0
    alpha.duration = 0.5
    alpha.fillMode = kCAFillModeBoth
    alpha.beginTime = CACurrentMediaTime() + 0.5
    cloud1.layer.add(alpha, forKey: nil)
    alpha.beginTime = CACurrentMediaTime() + 0.7
    cloud2.layer.add(alpha, forKey: nil)
    alpha.beginTime = CACurrentMediaTime() + 0.9
    cloud3.layer.add(alpha, forKey: nil)
    alpha.beginTime = CACurrentMediaTime() + 1.1
    cloud4.layer.add(alpha, forKey: nil)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let groupAnimation = CAAnimationGroup()
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.fillMode = kCAFillModeBackwards
    groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    let scaleDown = CABasicAnimation(keyPath: "transform.scale")
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1.0
    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = .pi/4.0
    rotate.toValue = 0.0
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 0.0
    fade.toValue = 1.0
    
    groupAnimation.animations = [scaleDown, rotate, fade]
    loginButton.layer.add(groupAnimation, forKey: nil)
    
    
    animateCloud(cloud1.layer)
    animateCloud(cloud2.layer)
    animateCloud(cloud3.layer)
    animateCloud(cloud4.layer)
    
    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = info.layer.position.x + view.bounds.width
    flyLeft.toValue = info.layer.position.x
    flyLeft.duration = 5.0
    flyLeft.repeatCount = 2.5
    flyLeft.autoreverses = true
    info.layer.add(flyLeft, forKey: "infoappear")
    
    let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
    fadeLabelIn.fromValue = 0.2
    fadeLabelIn.toValue = 1.0
    fadeLabelIn.duration = 4.5
    info.layer.add(fadeLabelIn, forKey: "fadein")
    
    username.delegate = self
    password.delegate = self
  }

  func showMessage(index: Int) {
    label.text = messages[index]

    UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromTop], animations: {
      self.status.isHidden = false
    }, completion: { _ in
      //transition completion
      delay(2.0) {
        if index < self.messages.count-1 {
          self.removeMessage(index: index)
        } else {
          //reset form
          self.resetForm()
        }
      }
    })
  }

  func removeMessage(index: Int) {
    UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
      self.status.center.x += self.view.frame.size.width
    }, completion: { _ in
      self.status.isHidden = true
      self.status.center = self.statusPosition

      self.showMessage(index: index+1)
    })
  }

  func resetForm() {
    UIView.transition(with: status, duration: 0.2, options: .transitionFlipFromTop, animations: {
      self.status.isHidden = true
      self.status.center = self.statusPosition
    }, completion: { _ in
        
    })

    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
      self.spinner.center = CGPoint(x: -20.0, y: 16.0)
      self.spinner.alpha = 0.0
      self.loginButton.bounds.size.width -= 80.0
      self.loginButton.center.y -= 60.0
    }, completion: { _ in
        let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
        tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
        roundCorners(layer: self.loginButton.layer, toRadius: 8.0)
    })
    
    let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.duration = 0.25
    wobble.repeatCount = 4
    wobble.values = [0.0, -.pi/4.0, 0.0, .pi/4.0, 0.0]
    wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    heading.layer.add(wobble, forKey: nil)
  }

  func animateCloud(_ layer: CALayer) {
    let cloudSpeed = 60.0 / Double(view.layer.bounds.width)
    let duration: TimeInterval = Double(view.layer.bounds.width - layer.frame.origin.x) * cloudSpeed
    
    let cloudMove = CABasicAnimation(keyPath: "position.x")
    cloudMove.duration = duration
    cloudMove.toValue = view.bounds.width + layer.bounds.width/2
    cloudMove.delegate = self
    cloudMove.setValue("cloud", forKey: "name")
    cloudMove.setValue(layer, forKey: "layer")
    layer.add(cloudMove, forKey: nil)
//    let cloudSpeed = 60.0 / view.frame.size.width
//    let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
//    UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
//      cloud.frame.origin.x = self.view.frame.size.width
//    }, completion: { _ in
//      cloud.frame.origin.x = -cloud.frame.size.width
//      self.animateCloud(cloud)
//    })
  }

  // MARK: further methods

  @IBAction func login() {
    view.endEditing(true)

    let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    tintBackgroundColor(layer: loginButton.layer, toColor: tintColor)
    
    roundCorners(layer: loginButton.layer, toRadius: 25.0)
    
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80.0
    }, completion: { _ in
      self.showMessage(index: 0)
    })

    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y += 60.0
      self.spinner.center = CGPoint(
        x: 40.0,
        y: self.loginButton.frame.size.height/2
      )
      self.spinner.alpha = 1.0
    }, completion: nil)

    
    let balloon = CALayer()
    balloon.contents = UIImage(named: "balloon")!.cgImage
    balloon.frame = CGRect(x: -50.0, y: 0.0, width: 50.0, height: 65.0)
    view.layer.insertSublayer(balloon, below: username.layer)
    let flight  = CAKeyframeAnimation(keyPath: "position")
    flight.duration = 12.0
    flight.values = [
        CGPoint(x: -50.0, y: 0.0),
        CGPoint(x: view.frame.width + 50.0, y: 160.0),
        CGPoint(x: -50.0, y: loginButton.center.y)
        ].map{NSValue(cgPoint: $0)}
    flight.keyTimes = [0.0, 0.5, 1.0]
    balloon.add(flight, forKey: nil)
    balloon.position = CGPoint(x: -50.0, y: loginButton.center.y)
  }

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }

}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Animation stoped.")
        guard let name = anim.value(forKey: "name") as? String, let layer = anim.value(forKey: "layer") as? CALayer
 else { return }
        if name == "form" {
            anim.setValue(nil, forKey: "layer")
            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.damping = 7.5
            pulse.fromValue = 1.25
            pulse.toValue = 1.0
            pulse.duration = pulse.settlingDuration
            layer.add(pulse, forKey: nil)
        } else if name == "cloud" {
            layer.position.x = -layer.bounds.width/2
            delay(0.5) {
                self.animateCloud(layer)
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let runningAnimations = info.layer.animationKeys() else { return }
        print(runningAnimations)
        for key in runningAnimations {
            info.layer.removeAnimation(forKey: key)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count < 5 {
            textField.layer.borderWidth = 3.0
            textField.layer.borderColor = UIColor.clear.cgColor
            
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.fromValue = textField.layer.position.y + 1.0
            jump.toValue = textField.layer.position.y
            jump.initialVelocity = 100.0
            jump.mass = 10.0
            jump.stiffness = 1500
            jump.damping = 50.0
            jump.duration = jump.settlingDuration
            textField.layer.add(jump, forKey: nil)

            let flash = CASpringAnimation(keyPath: "borderColor")
            flash.damping = 7.0
            flash.stiffness = 200
            flash.fromValue = UIColor.red.cgColor
            flash.toValue = UIColor.white.cgColor
            flash.duration = flash.settlingDuration
            textField.layer.add(flash, forKey: nil)
            
        }
    }
}
