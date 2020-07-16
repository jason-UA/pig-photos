//
//  PhotoHandler.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation
import Photos

class PhotoHandler {
    
    var isAuthorization = false
    
    static let sharedInstance = PhotoHandler()
    
    private init() {
        requestAuthorization()
    }
    
    public func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization {[weak self]  (status) in
            if status == PHAuthorizationStatus.authorized {
                self?.isAuthorization = true
            }else {
                self?.isAuthorization = false
            }
        }
    }
    
    func getAllPhotos() -> [Photo] {
        let assets = PHAsset.fetchAssets(with: nil)
        var photos:[Photo] = []
        assets.enumerateObjects { (asset, index, stop) in
            let photo = Photo(asset: asset)
            photos.append(photo)
        }
        return photos
    }
    
    func getAllAlbums() -> [Album]{
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil);
        var albums:[Album] = []
        collections.enumerateObjects { (collection, index, stop) in
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            let album = Album(result: assets, title: collection.localizedTitle ?? "unnamed!")
            albums.append(album)
        }
        return albums
    }
    
    func createAlbum(name: String) {
        var isExist = false
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil);
        collections.enumerateObjects { (collection, index, stop) in
            if name == collection.localizedTitle {
                isExist = true
                stop.initialize(to: true)
            }
        }
        if !isExist {
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            }) { (isSuccess, error) in
                print(isSuccess)
            }
        }
    }
    
    
    
}
