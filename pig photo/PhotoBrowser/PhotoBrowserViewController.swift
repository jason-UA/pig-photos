//
//  PhotoBrowserViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import Photos

class PhotoBrowserViewController: UIViewController {


    let photos: [Photo]
    
    var currentPage: Int
    
    init(photos: [Photo], currentPage: Int) {
        self.photos = photos
        self.currentPage = currentPage
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        self.title = "照片"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var photoBrowserCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = PhotoBrowserCollectionViewCell.cellsize()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.register(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoBrowserCollectionView)
        photoBrowserCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cachingImages()
        photoBrowserCollectionView.setContentOffset(CGPoint(x: currentPage * Int(PhotoBrowserCollectionViewCell.cellsize().width), y: 0) , animated: false)
    }
    
    func cachingImages() {
        PhotoHandler.sharedInstance.cachingImages(size: PhotoCollectionViewCell.cellsize(), assets: getTenNearbyPhotoAsset())
    }
    
    func getTenNearbyPhotoAsset() -> [PHAsset] {
        let count = photos.count
        if count < 10 {
            return slicePhotoAsset(start: 0, end: count)
        } else {
            if currentPage < 5 {
                return slicePhotoAsset(start: 0, end: 10)
            } else if currentPage > (count - 5) {
                let start = count - 10
                return slicePhotoAsset(start: start, end: count)
            } else {
                let start = currentPage - 5
                let end = currentPage + 5
                return slicePhotoAsset(start: start, end: end)
            }
        }
    }
    
    func slicePhotoAsset(start: Int, end: Int) -> [PHAsset] {
        return photos[start..<end].map { (photo) -> PHAsset in
            photo.asset
        }
    }
    

}

extension PhotoBrowserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoBrowserCollectionViewCell
        cell.photo = photos[indexPath.row]
        cell.showPhoto()
        currentPage = indexPath.row
        cachingImages()
        return cell
    }
    
    
    
}
