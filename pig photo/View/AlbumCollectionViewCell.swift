//
//  AlbumTableViewCell.swift
//  pig photo
//
//  Created by tianhe on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos
import SnapKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let countLabel = UILabel()
    
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
        imageView.layer.cornerRadius = 4;
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(self.imageView.snp.width)
        }
        
        nameLabel.textColor = UIColor.black
        countLabel.textColor = UIColor.gray
        countLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(3)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        countLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    
    }
    
    private func refreshView() {
        guard let album = album else {
            return
        }
        nameLabel.text = album.title
        countLabel.text = "\(album.count)"
        
        guard let assert = album.albumCover else {
            self.imageView.image = nil
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
