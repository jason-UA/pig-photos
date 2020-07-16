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
    
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = (UIScreen.main.bounds.width - 2*3) / 4
        let cellHeight = cellWidth
        layout.itemSize = CGSize.init(width: cellWidth, height: cellHeight)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        return cell
        
    }
    
    
    
}
