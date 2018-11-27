//
//  Album.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 27/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Album: NSObject {
    
    let collectionId : Int
    let artistName : String
    let collectionName : String
    let collectionCensoredName : String
    let artistViewUrl : String
    let collectionViewUrl : String
    let artworkUrl60 : String
    let artworkUrl100 : String
    let collectionPrice : Float
    let trackCount : Int
    let copyright : String
    let currency : String
    let releaseDate : String
    let primaryGenreName : String

    
    init(album: JSON){
        self.collectionId = album["collectionId"].intValue
        self.artistName = album["artistName"].stringValue
        self.collectionName = album["collectionName"].stringValue
        self.collectionCensoredName = album["collectionCensoredName"].stringValue
        self.artistViewUrl = album["artistViewUrl"].stringValue
        self.collectionViewUrl = album["collectionViewUrl"].stringValue
        self.artworkUrl60 = album["artworkUrl60"].stringValue
        self.artworkUrl100 = album["artworkUrl100"].stringValue
        self.collectionPrice = album["collectionPrice"].floatValue
        self.trackCount = album["trackCount"].intValue
        self.copyright = album["copyright"].stringValue
        self.currency = album["currency"].stringValue
        self.releaseDate = album["releaseDate"].stringValue
        self.primaryGenreName = album["primaryGenreName"].stringValue

    }

}
