/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class PatternView: UIView {
  
  public struct Constants {
    static let patternSize: CGFloat = 30.0
    static let patternRepeatCount = 2
  }
  
  enum PatternDirection: CaseIterable {
    case left
    case top
    case right
    case bottom
  }
  
  var fillColor:[CGFloat] = [1.0, 0.0, 0.0, 1.0]
  var direction: PatternDirection = .top
  
  let drawTriangle: CGPatternDrawPatternCallback = { _, context in
    let trianglePath = UIBezierPath(triangleIn: CGRect(x: 0, y: 0, width: Constants.patternSize, height: Constants.patternSize))
    context.addPath(trianglePath.cgPath)
    context.fillPath()
  }
  
  init(fillColor: [CGFloat], direction: PatternDirection = .top) {
    self.fillColor = fillColor
    self.direction = direction
    super.init(frame: CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    UIColor.white.setFill()
    context?.fill(rect)
    var callbacks = CGPatternCallbacks(version: 0, drawPattern: drawTriangle, releaseInfo: nil)
    let patternStepX: CGFloat = rect.width / CGFloat(Constants.patternRepeatCount)
    let patternStepY: CGFloat = rect.height / CGFloat(Constants.patternRepeatCount)
    let patternOffsetX: CGFloat = (patternStepX - Constants.patternSize) / 2.0
    let patternOffsetY: CGFloat = (patternStepY - Constants.patternSize) / 2.0
    var transform: CGAffineTransform
    switch direction {
    case .top:
      transform = .identity
    case .left:
      transform = CGAffineTransform(rotationAngle: CGFloat(1.5 * .pi))
    case .right:
      transform = CGAffineTransform(rotationAngle: CGFloat(0.5 * .pi))
    case .bottom:
      transform = CGAffineTransform(rotationAngle: CGFloat(1.0 * .pi))
    }
    transform = transform.translatedBy(x: patternOffsetX, y: patternOffsetY)
    let pattern = CGPattern(info: nil, bounds: CGRect(x: 0, y: 0, width: Constants.patternSize, height: Constants.patternSize), matrix: transform, xStep: patternStepX, yStep: patternStepY, tiling: .constantSpacing, isColored: false, callbacks: &callbacks)
    let baseSpace = CGColorSpaceCreateDeviceRGB()
    let patternSpace = CGColorSpace(patternBaseSpace: baseSpace)!
    context?.setFillColorSpace(patternSpace)
    context?.setFillPattern(pattern!, colorComponents: fillColor)
    context?.fill(rect)
    
  }
}

extension UIBezierPath {
  convenience init(triangleIn rect: CGRect) {
    self.init()
    let topOfTriangle = CGPoint(x: rect.width / 2, y: 0)
    let bottomLeftOfTriangle = CGPoint(x: 0, y: rect.height)
    let bottomRIghtOfTriangle = CGPoint(x: rect.width, y: rect.height)
    
    self.move(to: topOfTriangle)
    self.addLine(to: bottomLeftOfTriangle)
    self.addLine(to: bottomRIghtOfTriangle)
    
    self.close()
  }
}
