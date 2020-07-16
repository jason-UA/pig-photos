//
//  AlbumViewController.swift
//  pig photo
//
//  Created by jason on 2020/7/16.
//  Copyright © 2020 jason. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoHandler().createAlbum(name: "create")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
