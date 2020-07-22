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
    
    var albums: [Album] = [] {
        didSet {
            albumCollectionView.performBatchUpdates({
                albumCollectionView.reloadData()
            }, completion: nil)
        }
    }
    
    var okAction:UIAlertAction?
    
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
        PhotoHandler.sharedInstance.requestAuthorization(success: {
            let newalbums = PhotoHandler.sharedInstance.getAllAlbums()
            DispatchQueue.main.async {
                self.albums = newalbums
            }
        },faiure: nil)
        
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
        albumCollectionView.register(AlbumCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: AlbumCollectionViewCell.cellIdentifier)
        albumCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupCreateAlbumBtn() {
        let albumBtn = UIButton(type: .system)
        albumBtn.setTitle("新建", for: .normal)
        albumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        albumBtn.addTarget(self, action: #selector(albumClick), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: albumBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func albumClick() {
        
        let alertController = UIAlertController.init(title: "创建相册", message: "请为此相册输入名称", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "标题"
            textfield.keyboardType = .asciiCapable
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        okAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            if let title = alertController.textFields?.first?.text {
                PhotoHandler.sharedInstance.createAlbum(name: title)
                self.refreshAlbums()
            }
        }
        okAction?.isEnabled = false
        alertController.textFields?.first?.delegate = self
        alertController.addAction(cancel)
        alertController.addAction(okAction!)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        let alphotoController = AlbumPhotoViewController(album: album)
        self.navigationController?.pushViewController(alphotoController, animated: true)
        
    }

}

extension AlbumViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        okAction?.isEnabled = textField.text?.count ?? 0 > 0
        return true
    }
}
