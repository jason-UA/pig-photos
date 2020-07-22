//
//  AlbumPhotoViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit

class AlbumPhotoViewController: UIViewController {
    
    private let album: Album
    
    private let photos: [Photo]
    
    private let photoCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupAdditionBtn()
        // Do any additional setup after loading the view.
    }
    
    init(album: Album) {
        self.album = album
        self.photos = album.photos
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        self.title = album.title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAdditionBtn() {
        let albumBtn = UIButton(type: .system)
        albumBtn.setTitle("添加", for: .normal)
        albumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        albumBtn.addTarget(self, action: #selector(additionClick), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: albumBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func additionClick() {
        let photoPickerViewController = PhotoPickerViewController(album: album)
        let navigationController = UINavigationController(rootViewController: photoPickerViewController)
        self.present(navigationController, animated: true, completion: nil)
        
    }

    private func setupCollectionView() {
        view.addSubview(photoCollectionView)
        let layout = photoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = PhotoCollectionViewCell.cellsize()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        photoCollectionView.alwaysBounceVertical = true
        photoCollectionView.register(PhotoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.collectionViewLayout = layout
        photoCollectionView.backgroundColor = UIColor.white
        photoCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}

extension AlbumPhotoViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photo = photos[indexPath.row]
        cell.refreshView()
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotoCollectionViewCell {
            cell.cancelFetchPhoto()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let photoBrowserViewController = PhotoBrowserViewController(photos: photos, currentPage: indexPath.row)
         self.navigationController?.pushViewController(photoBrowserViewController, animated: true)
     }
}
