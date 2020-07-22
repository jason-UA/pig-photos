//
//  PhotoHandler.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation
import Photos
import UIKit

class PhotoHandler {
    
    static let sharedInstance = PhotoHandler()
    
    let imageManager = PHCachingImageManager()
    
    var collectPhoto:Set<String> = []
    
    var isAuthorized = false
    
    
    let imageRequestOption: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.resizeMode = .exact
        options.deliveryMode = .opportunistic
        options.isNetworkAccessAllowed = true
        return options
    }()
    
    
    private init() {
        
    }
    
    func requestAuthorization(success: @escaping() -> Void, faiure: (() -> Void)?) {
        PHPhotoLibrary.requestAuthorization {[weak self]  (status) in
            if status == PHAuthorizationStatus.authorized {
                if !self!.isAuthorized {
                    self?.cachingImages(size: PhotoCollectionViewCell.cellsize(), assets: PHAsset.fetchAssets(with: nil).objects(at: .init()))
                    self?.collectionPhotos()
                }
                self?.isAuthorized = true
                success()
            }else {
                faiure?()
            }
        }
    }
    
    func scaleSize(size: CGSize) -> CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    func cachingImages(size: CGSize, assets: [PHAsset]) {
        imageManager.startCachingImages(for: assets, targetSize: scaleSize(size: size) , contentMode: .aspectFill, options: imageRequestOption)
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
            let album = Album(collection: collection)
            albums.append(album)
        }
        return albums
    }
    
    private func collectionPhotos() {
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil);
        collections.enumerateObjects { (collection, index, stop) in
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            assets.enumerateObjects { [weak self](asset, index, stop) in
                self?.collectPhoto.insert(asset.localIdentifier)
            }
        }
    }
    
    func getUnCollectionPhotos() -> [Photo] {
        let photos = getAllPhotos()
        return photos.filter { (photo) -> Bool in
            !self.collectPhoto.contains(photo.asset.localIdentifier)
        }
    }
    
    func fetchPhoto(assert: PHAsset, size: CGSize, resultHandler: @escaping (UIImage?) -> Void) -> PHImageRequestID {
        let requestID = imageManager.requestImage(for: assert, targetSize: scaleSize(size: size), contentMode: .aspectFit, options: imageRequestOption) {(image, info) in
            resultHandler(image)
        }
        return requestID
    }
    
    func cancelRequestPhoto(requestID: PHImageRequestID) {
        imageManager.cancelImageRequest(requestID)
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
