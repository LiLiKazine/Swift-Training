//
//  ViewController.swift
//  Extendable Table
//
//  Created by LiLi Kazine on 2018/11/18.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var artistsTable: UITableView!
    
    let artists = Artist.artistsFromBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistsTable.rowHeight = UITableView.automaticDimension
        artistsTable.estimatedRowHeight = 140
                
//        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
//            self?.artistsTable.reloadData()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController, let indexPath = artistsTable.indexPathForSelectedRow {
            dest.selected = artists[indexPath.row]
        }
    }

}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        let artist = artists[indexPath.row]
        cell.contentLbl.text = artist.bio
        cell.contentLbl.textColor = UIColor(white: 114/255, alpha: 1)
        
        cell.avatarImg.image = artist.image
        cell.nameLbl.text = artist.name
        
        cell.nameLbl.backgroundColor = UIColor(red: 1, green: 152 / 255, blue: 0, alpha: 1)
        cell.nameLbl.textColor = UIColor.white
        cell.nameLbl.textAlignment = .center
        cell.selectionStyle = .none
        
        cell.nameLbl.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.contentLbl.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
    
    
}
