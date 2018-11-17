//
//  ViewController.swift
//  Stopwatch
//
//  Created by LiLi Kazine on 2018/11/15.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainCounterLbl: UILabel!
    @IBOutlet weak var lapsCounterLbl: UILabel!
    @IBOutlet weak var funcBtn: UIButton!
    @IBOutlet weak var ctrlBtn: UIButton!
    @IBOutlet weak var lapsTable: UITableView!
    
    private let mainStopwatch = Stopwatch()
    private let lapStopwatch = Stopwatch()
    
    private var isRunning = false
    private var laps: [String] = []
    
    private let initBtn: (UIButton) -> Void = { button in
        button.layer.cornerRadius = 0.5 * button.bounds.width
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.backgroundColor = .white
    }
    
    private let designBtn: (UIButton, String, UIColor) -> Void = { btn, str, color in
        btn.setTitle(str, for: UIControl.State())
        btn.setTitleColor(color, for: UIControl.State())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBtn(funcBtn)
        initBtn(ctrlBtn)
        designBtn(funcBtn, "Lap", .lightGray)
        designBtn(ctrlBtn, "Start", .green)
        
        funcBtn.isEnabled = false
        
        lapsTable.delegate = self
        lapsTable.dataSource = self
        
    }

    override var shouldAutorotate: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    @IBAction func btnClickAction(_ sender: UIButton) {
        
        switch sender {
        case funcBtn:
            funcBtnClick(sender: sender)
        case ctrlBtn:
            ctrlBtnClick(sender: sender)
        default:
            break
        }
    }
    
    private func funcBtnClick(sender: UIButton) {
        if isRunning {
            if let mainText = mainCounterLbl.text {
                laps.append(mainText)
                lapsTable.reloadData()
                resetLapTimer()
                unowned let weakSelf = self
                lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
                RunLoop.current.add(lapStopwatch.timer, forMode: .common)
            }
        } else {
            resetMainTimer()
            resetLapTimer()
            designBtn(funcBtn, "Lap", .lightGray)
            funcBtn.isEnabled = false
        }
        
        
    }
    
    private func ctrlBtnClick(sender: UIButton) {
        funcBtn.isEnabled = true
        
        if isRunning {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            designBtn(sender, "Start", .green)
            designBtn(funcBtn, "Reset", .black)
            isRunning = false
        } else {
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopwatch.timer, forMode: .common)
            RunLoop.current.add(lapStopwatch.timer, forMode: .common)

            isRunning = true
            
            designBtn(ctrlBtn, "Stop", .red)
            designBtn(funcBtn, "Lap", .black)
        }
    }
    
    private func resetLapTimer() {
        resetTimer(watch: lapStopwatch, lbl: lapsCounterLbl)
    }
    
    private func resetMainTimer() {
        resetTimer(watch: mainStopwatch, lbl: mainCounterLbl)
        laps.removeAll()
        lapsTable.reloadData()
    }
    
    private func resetTimer(watch: Stopwatch, lbl: UILabel) {
        watch.timer.invalidate()
        watch.counter = 0.0
        lbl.text = "00:00:00"
    }
    
    
    
    @objc func updateMainTimer() {
        updateTimer(watch: mainStopwatch, lbl: mainCounterLbl)
    }
    
    @objc func updateLapTimer() {
        updateTimer(watch: lapStopwatch, lbl: lapsCounterLbl)
    }
    
    private func updateTimer(watch: Stopwatch, lbl: UILabel) {
        watch.counter += 0.035
        
        let min: Int = Int(watch.counter/60)
        let minStr = String(format: "%02d", min)
        
        let sec = watch.counter.truncatingRemainder(dividingBy: 60)
        let secStr = String(format: "%05.2f", sec)
        
        lbl.text = minStr + ":" + secStr
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "lapCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        cell?.textLabel?.text = laps[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

