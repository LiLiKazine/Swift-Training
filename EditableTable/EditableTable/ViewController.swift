//
//  ViewController.swift
//  EditableTable
//
//  Created by LiLi Kazine on 2018/11/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = ["item1", "item2", "item3", "item4"]
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        let roundBtn: (UIButton) -> Void = { btn in
            btn.layer.cornerRadius = btn.bounds.width/2
        }
        roundBtn(reloadBtn)
        roundBtn(editBtn)
    }

    @IBAction func btnAction(_ sender: UIButton) {
        switch sender {
        case reloadBtn:
            table.reloadData()
        case editBtn:
            table.setEditing(!table.isEditing, animated: true)
        default:
            break
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
    }
    
}

