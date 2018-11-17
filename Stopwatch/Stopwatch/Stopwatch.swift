//
//  Stopwatcha.swift
//  Stopwatch
//
//  Created by LiLi Kazine on 2018/11/15.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {

    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
    
    
}
