//
//  DetailViewController.swift
//  Extendable Table
//
//  Created by LiLi Kazine on 2018/11/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selected: Artist!
    
    let moreInfoText = "Select For More Info >"

    @IBOutlet weak var detailTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selected.name
        
        detailTable.rowHeight = UITableView.automaticDimension
        detailTable.estimatedRowHeight = 300
//        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
//            self?.detailTable.reloadData()
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailTableViewCell
        let work = selected.works[indexPath.row]
        cell.nameLbl.text = work.title
        cell.avatarImg.image = work.image
        
        cell.nameLbl.backgroundColor = UIColor(white: 204/255, alpha: 1)
        cell.nameLbl.textAlignment = .center
        cell.detailTv.textColor = UIColor(white: 114 / 255, alpha: 1)
        cell.selectionStyle = .none
        
        cell.detailTv.text = work.isExpanded ? work.info : moreInfoText
        cell.detailTv.textAlignment = work.isExpanded ? .left : .center
        
        cell.nameLbl.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.detailTv.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailTableViewCell else { return }
        var work = selected.works[indexPath.row]
        work.isExpanded = !work.isExpanded
        selected.works[indexPath.row] = work
        cell.detailTv.text = work.isExpanded ? work.info : moreInfoText
        cell.detailTv.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
}
