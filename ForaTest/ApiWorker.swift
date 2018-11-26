//
//  ApiWorker.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 26/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiWorker: NSObject {
    
    static let shared = ApiWorker()
    
    let searchAlbumAdress = "https://itunes.apple.com/search?entity=album"
    let searchSongsByAlbum = "https://itunes.apple.com/lookup?media=music&entity=song&limit=200"
    
    func getAlbumsBySearch(albumName: String, countryCode: String, completionHandler: @escaping (String, Error?) -> (Void)){
        Alamofire.request(searchAlbumAdress, method: .get, parameters: ["country": countryCode, "term": albumName] ).responseJSON{
                json in
                print(json)
        }    }
    
    func getSongsByAlbum(albumId: Int, countryCode: String, completionHandler: @escaping (String, Error?) -> (Void)){
        Alamofire.request(searchSongsByAlbum, method: .get, parameters: ["country": countryCode, "id": albumId]).responseJSON{
            json in
            print(json)
        }
    }
    
}
