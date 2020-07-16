//
//  AlbumTableViewCell.swift
//  pig photo
//
//  Created by tianhe on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class AlbumCollectionViewCell: UICollectionViewCell {
    
    
    let imageView = UIImageView()
    
    var album: Album? {
        didSet{
            refreshView()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "default")
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func refreshView() {
        guard let assert = album?.albumCover else {
            return
        }
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = true
        PHCachingImageManager.default().requestImage(for: assert, targetSize: CGSize(width: 50, height: 50), contentMode: .aspectFill, options: options) {[weak self] (image, info) in
            self?.imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
