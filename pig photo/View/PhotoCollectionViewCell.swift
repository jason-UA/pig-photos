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
    
    func refreshView() {
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = true
        PHCachingImageManager.default().requestImage(for: photo!.asset, targetSize: CGSize(width: 50, height: 50), contentMode: .aspectFill, options: options) {[weak self] (image, info) in
            self?.imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
