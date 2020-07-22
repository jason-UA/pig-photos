//
//  Album.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class Album {
    
    let collection: PHAssetCollection
    /// 相册里的照片
    var photos:[Photo] = []
    /// 相册的封面
    var albumCover : PHAsset?
    /// 相册标题
    var title : String
    /// 相册的照片个数
    var count : Int
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - result: 相册数据
    ///   - title: 标题
    init(collection: PHAssetCollection) {
        self.title = collection.localizedTitle ?? ""
        self.collection = collection
        var photos:[Photo] = []
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        assets.enumerateObjects {(asset, index, stop) in
            let photo = Photo(asset: asset)
            photos.append(photo)
        }
        self.photos = photos
        albumCover = photos.first?.asset
        self.count = photos.count
    }
    
}
