//
//  PhotoPickerViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit

class PhotoPickerViewController: UIViewController {
    
    
    let effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        return effectView
    }()
    
    lazy var photoPickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = PhotoPickerCollectionViewCell.cellsize()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.register(PhotoPickerCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoPickerCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    let albumName: String
    
    let photos = PhotoHandler.sharedInstance.getUnCollectionPhotos()
    
    
    
    init(name: String) {
        albumName = name
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(effectView)
        effectView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.insertSubview(photoPickerCollectionView, belowSubview: effectView)
        photoPickerCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    
}

extension PhotoPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoPickerCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoPickerCollectionViewCell
        cell.photo = photos[indexPath.row]
        cell.refreshView()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotoPickerCollectionViewCell {
            cell.cancelFetchPhoto()
        }
    }
    
    
}
