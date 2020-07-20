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
        title = "相册"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshAlbums()
    }
    
    func setupView() {
        setupCollectionView()
        setupCreateAlbumBtn()
    }
    
    func refreshAlbums() {
        DispatchQueue.global().async {
            let newalbums = PhotoHandler.sharedInstance.getAllAlbums()
            DispatchQueue.main.async {
                self.albums = newalbums
            }
        }
    }
    
    func setupCollectionView() {
        view.addSubview(albumCollectionView)
        let layout = albumCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = AlbumCollectionViewCell.cellsize()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        albumCollectionView.alwaysBounceVertical = true
        albumCollectionView.backgroundColor = UIColor.white
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.register(AlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: albumCollectionCellIdenrigier)
        albumCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupCreateAlbumBtn() {
        let albumBtn = UIButton(type: .system)
        albumBtn.setTitle("新增", for: .normal)
        albumBtn.addTarget(self, action: #selector(albumClick), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: albumBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func albumClick() {
        
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
