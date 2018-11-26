//
//  ViewController.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 26/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,  UISearchBarDelegate, UISearchDisplayDelegate {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiWorker.shared.getSongsByAlbum(albumId: 526041016, countryCode: "RU"){
            _,_  in
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }


}

