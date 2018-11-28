//
//  AlbumInfoTableViewCell.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 28/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit

class AlbumInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreNameLavel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize(album: Album){//initialize cell
        self.albumImage.imageFromServerURL(urlString: album.artworkUrl100)
        self.albumNameLabel.text = album.collectionCensoredName
        self.albumNameLabel.lineBreakMode = .byWordWrapping
        self.albumNameLabel.numberOfLines = 2;
        self.artistNameLabel.text = album.artistName
        self.priceLabel.text = "\(album.collectionPrice)"
        self.currencyLabel.text = album.currency
        self.releaseDateLabel.text = self.dateFormatToString( dateString: album.releaseDate)
        self.genreNameLavel.text = "\(album.primaryGenreName)"
        self.copyrightLabel.text = album.copyright
    }
    
    /// Transforming date format to correct format
    func dateFormatToString(dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date!)
        
    }
    

}
