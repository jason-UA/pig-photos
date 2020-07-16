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
    
    /// 相册里的数据
    var fetchResult : PHFetchResult<PHAsset>
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
        fetchResult = result
        count = fetchResult.count
        if fetchResult.count > 0 {
            albumCover = fetchResult.firstObject
        }
        
    }
    
}
