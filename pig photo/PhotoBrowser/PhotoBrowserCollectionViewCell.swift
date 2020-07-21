//
//  PhotoBrowserCollectionViewCell.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class PhotoBrowserCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "PhotoBrowserCellIdentifier"
    
    class func cellsize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    let imageView = UIImageView(frame: CGRect.zero)
    
    var photo: Photo?
    
    var reqeustID: PHImageRequestID?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func showPhoto() {
        guard let asset = photo?.asset else {
            self.imageView.image = nil
            return
        }
        reqeustID = PhotoHandler.sharedInstance.fetchPhoto(assert: asset, size: PhotoBrowserCollectionViewCell.cellsize()) {[weak self] (image) in
            if let image = image {
              self?.imageView.image = image
            }
        }
    }
    
    func cancelfetchImage() {
        if let reqeustID = reqeustID {
            PhotoHandler.sharedInstance.cancelRequestPhoto(requestID: reqeustID)
            self.reqeustID = nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
