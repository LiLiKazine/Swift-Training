//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by LiLi Kazine on 2018/12/17.
//  Copyright © 2018 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photoName: String!
    
    public var photoIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoName = photoName {
            photoView.image = UIImage(named: photoName)
        }
        
        let generalTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(generalTapGesture)
        let zoomTapGesture = UITapGestureRecognizer(target: self, action: #selector(openZoomingController(sender:)))
        photoView.addGestureRecognizer(zoomTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,
            let vc = segue.destination as? ZoomedPhotoViewController {
            if id == "zooming" {
                vc.photoName = photoName
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func openZoomingController(sender: AnyObject) {
        performSegue(withIdentifier: "zooming", sender: nil)
    }
    
    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1: -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        adjustInsetForKeyboard(isShow: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        adjustInsetForKeyboard(isShow: false, notification: notification)
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
