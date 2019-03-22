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
import QuartzCore

class ViewController: UIViewController {
  
  @IBOutlet var bgImageView: UIImageView!
  
  @IBOutlet var summaryIcon: UIImageView!
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNr: UILabel!
  @IBOutlet var gateNr: UILabel!
  @IBOutlet var departingFrom: UILabel!
  @IBOutlet var arrivingTo: UILabel!
  @IBOutlet var planeImage: UIImageView!
  
  @IBOutlet var flightStatus: UILabel!
  @IBOutlet var statusBanner: UIImageView!
  
  //MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adjust ui
    summary.addSubview(summaryIcon)
    summaryIcon.center.y = summary.frame.size.height/2
    
    //start rotating the flights
    changeFlightDataTo(londonToParis)
    
    
    let rect = CGRect(x: 0.0, y: -70, width: view.bounds.width, height: 50.0)
    let emitter = CAEmitterLayer()
    emitter.frame = rect
//    emitter.backgroundColor = UIColor.white.cgColor
    view.layer.addSublayer(emitter)
    
    emitter.emitterShape = kCAEmitterLayerRectangle
    emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
    emitter.emitterSize = rect.size
   
    let emitterCell1 = CAEmitterCell()
    emitterCell1.contents = UIImage(named: "flake.png")?.cgImage
    emitterCell1.birthRate = 50
    emitterCell1.lifetime = 3.5
    let emitterCell2 = CAEmitterCell()
    emitterCell2.contents = UIImage(named: "flake1.png")?.cgImage
    emitterCell2.birthRate = 50
    emitterCell2.lifetime = 3.5
    let emitterCell3 = CAEmitterCell()
    emitterCell3.contents = UIImage(named: "flake2.png")?.cgImage
    emitterCell3.birthRate = 50
    emitterCell3.lifetime = 3.5
    emitter.emitterCells = [emitterCell1, emitterCell2, emitterCell3]
    adjustCell(cell: emitterCell1)
    adjustCell(cell: emitterCell2)
    adjustCell(cell: emitterCell3)
  }
    
    func adjustCell(cell: CAEmitterCell) {
        
        cell.yAcceleration = 70.0
        cell.xAcceleration = 10.0
        cell.velocity = 20.0
        cell.emissionLongitude = -.pi
        cell.velocityRange = 200.0
        cell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        cell.redRange = 0.1
        cell.greenRange = 0.1
        cell.blueRange = 0.1
        cell.scale = 0.8
        cell.scaleRange = 0.8
        cell.scaleSpeed = -0.15
        cell.alphaRange = 0.75
        cell.alphaSpeed = -0.15
        cell.lifetimeRange = 1.0
    }
  
  //MARK: custom methods
  
  func changeFlightDataTo(_ data: FlightData) {
    
    // populate the UI with the next flight's data
    summary.text = data.summary
    flightNr.text = data.flightNr
    gateNr.text = data.gateNr
    departingFrom.text = data.departingFrom
    arrivingTo.text = data.arrivingTo
    flightStatus.text = data.flightStatus
    bgImageView.image = UIImage(named: data.weatherImageName)
  }
  
  
}
