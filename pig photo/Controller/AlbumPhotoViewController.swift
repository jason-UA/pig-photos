//
//  AlbumPhotoViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/21.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit

class AlbumPhotoViewController: UIViewController {
    
    private let photos: [Photo]
    
    private let photoCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    init(photos: [Photo], title: String) {
        self.photos = photos
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        self.title = title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if let cell = cell as? PhotoCollectionViewCell {
             cell.refreshView()
         }
     }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotoCollectionViewCell {
            cell.cancelFetchPhoto()
        }
    }
}
