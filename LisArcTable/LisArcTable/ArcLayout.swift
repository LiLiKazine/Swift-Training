//
//  ArcLayout.swift
//  LisArcTable
//
//  Created by LiLi Kazine on 2019/1/2.
//  Copyright © 2019 HNA Group Co.,Ltd. All rights reserved.
//

import UIKit

class ArcLayout: UICollectionViewLayout {
    
    // Cache calculated attributes.
    var cellAttrsDic = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    var dataSourceDidUpdate = true
    
    var viewAnchor: CGPoint {
        if let anchor = collectionView?.frame.origin {
            return anchor
        } else {
            return CGPoint.zero
        }
    }
    
    var viewSize: CGSize {
        if let size = collectionView?.bounds.size {
            return size
        } else {
            return CGSize.zero
        }
    }
    
    var contentWidth: CGFloat {
        get {
            guard let collectionView = collectionView else {
                return 0
            }
            let insets = collectionView.contentInset
            return collectionView.bounds.width - (insets.left + insets.right)
        }
    }
    
    var contentHeight: CGFloat = 0.0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        if !dataSourceDidUpdate {
            // Nothing has changed.
            return
        }
        
        cellAttrsDic.removeAll()
        
        dataSourceDidUpdate = false
        
        var path = UIBezierPath(arcCenter: CGPoint(x: 0, y: viewSize.height / 2 + viewAnchor.y), radius: viewSize.height / 2, startAngle: 0.0, endAngle: CGFloat.pi, clockwise: true)
        
        guard let sectionCount = collectionView?.numberOfSections, sectionCount > 0 else {
            return
        }
        for section in 0 ..< sectionCount {
            guard let rowCount = collectionView?.numberOfItems(inSection: section), rowCount > 0 else {
                continue
            }
            for row in 0 ..< rowCount {
                
            }
        }
        
        
        
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//    }

//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//
//    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
