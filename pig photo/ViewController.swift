//
//  ViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        te()
        getAllPhotos()
        getAllAlbums()
        // Do any additional setup after loading the view.
    }
    
    func te() {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == PHAuthorizationStatus.authorized {
                print("authorized")
            }else {
                print(" else")
            }
        }
    }
    
    func getAllPhotos() {
        let phAssets = PHAsset.fetchAssets(with: nil)
        print(phAssets.count)
    }
    
    func getAllAlbums() {
        let favoritesCollection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil);
        favoritesCollection.enumerateObjects { (collection, index, stop) in
//            let asset = PHAsset.fetchAssets(with: collection)
            print(collection.localizedTitle)
        }
        
    }


}

