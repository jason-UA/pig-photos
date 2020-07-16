//
//  PhotoCollectionViewCell.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
