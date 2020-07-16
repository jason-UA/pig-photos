//
//  AlbumViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit
import SnapKit

class AlbumViewController: UIViewController {
    let albumCollectionCellIdenrigier = "albumCollectionCell"
    
    var albums: [Album] = [] {
        didSet {
            albumCollectionView.reloadData()
        }
    }
    
    
    let albumCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albums = PhotoHandler.sharedInstance.getAllAlbums()
    }
    
    func setupView() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(albumCollectionView)
        let layout = albumCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = (UIScreen.main.bounds.width - 5*3) / 2
        let cellHeight = cellWidth + 30
        layout.itemSize = CGSize.init(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        albumCollectionView.alwaysBounceVertical = true
        albumCollectionView.backgroundColor = UIColor.white
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.register(AlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: albumCollectionCellIdenrigier)
        albumCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCollectionCellIdenrigier, for: indexPath) as! AlbumCollectionViewCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
    
    
}
