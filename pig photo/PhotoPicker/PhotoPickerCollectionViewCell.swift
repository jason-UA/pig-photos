//
//  PhotoPickerCollectionViewCell.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class PhotoPickerCollectionViewCell: UICollectionViewCell {
    
    
    static let cellIdentifier = "PhotoPickerCellIdentifier"
    
    let imageView = UIImageView()
    
    var reqeustID: PHImageRequestID?
    
    var photo:Photo?
    
    let timeLabel = UILabel()
    
    let pickerView: UIView = {
        let contectView = UIView()
        contectView.backgroundColor = UIColor.clear
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.25
        contectView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let picker = UIImageView(image: UIImage(named: "photo_picked"))
        contectView.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.bottom.right.equalToSuperview().offset(-5)
        }
        contectView.isHidden = true
        return contectView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        timeLabel.textColor = UIColor.white
        timeLabel.isHidden = true
        timeLabel.textAlignment = .right
        timeLabel.text = "0"
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(15)
        }
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancelFetchPhoto() {
        if let reqeustID = reqeustID {
            PhotoHandler.sharedInstance.cancelRequestPhoto(requestID: reqeustID)
            self.reqeustID = nil
        }
    }
    
    func refreshView() {
        guard let asset = photo?.asset else {
            self.imageView.image = nil
            timeLabel.isHidden = true
            pickerView.isHidden = true
            return
        }
        if asset.mediaType == .video {
            timeLabel.isHidden = false
            let timeStamp = lroundf(Float(asset.duration))
            let s = timeStamp % 60
            let m = (timeStamp - s) / 60 % 60
            let time = String(format: "%.2d:%.2d",  m, s)
            timeLabel.text = time
            
        } else if asset.mediaType == .image {
            timeLabel.isHidden = true
        }
        pickerView.isHidden = !photo!.isPicked
        reqeustID = PhotoHandler.sharedInstance.fetchPhoto(assert: asset, size: PhotoCollectionViewCell.cellsize()) {[weak self] (image) in
            if let image = image {
                self?.imageView.image = image
            }
        }
        
    }
    
    class func cellsize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 2*2) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    
}
