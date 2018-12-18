//
//  ViewController.swift
//  Tumblr
//
//  Created by LiLi Kazine on 2018/12/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navigationController?.toolbar.clipsToBounds = true
    }


    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
}

