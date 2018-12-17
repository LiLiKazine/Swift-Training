//
//  CollectionViewController.swift
//  PhotoScroll
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let thumbnailSize:CGFloat = 70.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UICollectionViewCell,
//            let indexPath = collectionView.indexPath(for: cell),
//            let zoomed = segue.destination as? ZoomedPhotoViewController {
//            zoomed.photoName = "Photo\(indexPath.row+1)"
//        }
//
//        if let cell = sender as? UICollectionViewCell,
//            let indexPath = collectionView.indexPath(for: cell),
//            let comment = segue.destination as? PhotoCommentViewController {
//            comment.photoName = "Photo\(indexPath.row+2)"
//        }
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let manage = segue.destination as? ManagePageViewController {
            manage.photos = photos
            manage.curIdx = indexPath.row
        }
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
    
        // Configure the cell
        let fullSizeImg = UIImage(named: photos[indexPath.row])
        cell.imgView.image = fullSizeImg?.thumbnailOfSize(thumbnailSize)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
