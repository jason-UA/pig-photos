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
    init(result:PHFetchResult<PHAsset>,title:String) {
        self.title = title
        var photos:[Photo] = []
        result.enumerateObjects {(asset, index, stop) in
            let photo = Photo(asset: asset)
            photos.append(photo)
        }
        self.photos = photos
        albumCover = photos.first?.asset
        self.title = title
        self.count = photos.count
    }
    
}
