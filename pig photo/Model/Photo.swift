//
//  Photo.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class Photo {
    
    /// 图片集合
    var assert:PHAsset
    
    public init(asset:PHAsset) {
        self.assert = asset
    }

}
