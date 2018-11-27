//
//  AlbumCollectionViewCell.swift
//  Alamofire
//
//  Created by Konstantin Fomin on 27/11/2018.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumName: UILabel!
    func initialize(album: Album){
        self.albumName.text = album.collectionName
    }
    
}
