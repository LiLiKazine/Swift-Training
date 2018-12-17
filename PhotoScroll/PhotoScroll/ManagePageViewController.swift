//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    
    
    var photoName: String!

    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var curIdx: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let vc = viewPhotoCommentViewController(index: curIdx ?? 0) {
            let vcs = [vc]
            setViewControllers(vcs, direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func viewPhotoCommentViewController(index: Int) -> PhotoCommentViewController? {
        if let sb = storyboard,
            let page = sb.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController {
            page.photoName = photos[index]
            page.photoIndex = index
            return page
        }
        return nil
    }

}

extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc =  viewController as? PhotoCommentViewController {
            guard let idx = vc.photoIndex, idx != 0 else {
                return nil
            }
            return viewPhotoCommentViewController(index: idx - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? PhotoCommentViewController {
            guard let idx = vc.photoIndex, idx != photos.count-1 else {
                return nil
            }
            return viewPhotoCommentViewController(index: idx + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return curIdx ?? 0
    }
}
