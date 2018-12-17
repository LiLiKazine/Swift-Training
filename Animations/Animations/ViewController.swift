//
//  ViewController.swift
//  Animations
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let headerHeight: CGFloat = 50.0
    let duration = 0.5
    
    @IBOutlet weak var masterTableView: UITableView!
    
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position",
                             "Color and Frame Change", "View Fade In", "Pop"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
    func animateTable() {
        masterTableView.reloadData()
        
        let cells = masterTableView.visibleCells
        let tableHeight = masterTableView.bounds.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations:  {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController,
            let indexPath = masterTableView.indexPathForSelectedRow {
            vc.barTitle = items[indexPath.row]
        }
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
}

