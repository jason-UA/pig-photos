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
    var asset:PHAsset
    
    var isPicked = false
    
    
    public init(asset:PHAsset) {
        self.asset = asset
    }

}

extension Photo: Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.asset.localIdentifier == rhs.asset.localIdentifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(asset.localIdentifier)
    }
    
    
}
