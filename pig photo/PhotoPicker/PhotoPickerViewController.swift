//
//  PhotoPickerViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit

class PhotoPickerViewController: UIViewController {
    
    lazy var photoPickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = PhotoPickerCollectionViewCell.cellsize()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
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
        title = "选择照片"
        navigationItem.prompt = "将照片添加到\"\(name)\"。"
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("完成", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        doneButton.addTarget(self, action: #selector(doneClick), for: .touchUpInside)
        let doneItem = UIBarButtonItem(customView: doneButton)
        navigationItem.rightBarButtonItem = doneItem
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelClick))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(photoPickerCollectionView)
        photoPickerCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func doneClick() {
        
    }
    
    @objc func cancelClick() {
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        photo.isPicked = !photo.isPicked
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
    
    
}
