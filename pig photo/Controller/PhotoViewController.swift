//
//  PhotoViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import SnapKit

class PhotoViewController: UIViewController {
    
    private let cellIdentifier = "PhotoCell"
    private var photos: [Photo] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "未分类照片"
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshPhotos()
    }
    
    func refreshPhotos() {
        DispatchQueue.global().async {
            let newPhotos = PhotoHandler.sharedInstance.getUnCollectionPhotos()
            DispatchQueue.main.async {
                self.photos = newPhotos
            }
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = PhotoCollectionViewCell.cellsize()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView.alwaysBounceVertical = true
        collectionView.register(PhotoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.white
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}

extension PhotoViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photo = photos[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotoCollectionViewCell {
            cell.cancelFetchPhoto()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    
    
}
