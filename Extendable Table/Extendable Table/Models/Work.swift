//
//  Work.swift
//  Extendable Table
//
//  Created by LiLi Kazine on 2018/11/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

struct Work {
    let title: String
    let image: UIImage
    let info: String
    var isExpanded: Bool
    
    init(title: String,image: UIImage,info: String, isExpanded: Bool) {
        self.title = title
        self.image = image
        self.info = info
        self.isExpanded = isExpanded
    }
}
