//
//  PhotoCollectionViewCell.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import SnapKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    var reqeustID: PHImageRequestID?
    
    var photo:Photo?{
        didSet{
            refreshView()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func cancelFetchPhoto() {
        if let reqeustID = reqeustID {
            PhotoHandler.sharedInstance.cancelRequestPhoto(requestID: reqeustID)
        }
    }
    
    func refreshView() {
        guard let assert = photo?.assert else {
            self.imageView.image = nil
            return
        }
//        self.imageView.image = self.photo?.cachePhoto
        reqeustID = PhotoHandler.sharedInstance.fetchPhoto(assert: assert, size: PhotoCollectionViewCell.cellsize()) {[weak self] (image) in
            if let image = image {
                self?.imageView.image = image
//                self?.photo?.cachePhoto = image
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellsize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 2*3) / 4
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
