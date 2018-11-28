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
    
    static let shared = ApiWorker()// shared variable to do singleton class
    
    let searchAlbumAdress = "https://itunes.apple.com/search?entity=album"
    let searchSongsByAlbum = "https://itunes.apple.com/lookup?media=music&entity=song&limit=200"
    let localeCode = Locale.current.regionCode// get locale of device to search in iTunes
    
    func getAlbumsBySearch(albumName: String, completionHandler: @escaping ([Album]) -> (Void), errorCallback: @escaping (_ error: Error) -> (Void)){
        Alamofire.request(searchAlbumAdress, method: .get, parameters: ["country": localeCode!, "term": albumName] ).responseJSON{
                responce in
            if responce.response?.statusCode == 200 { // error handling on responce
                // at first, we transforming responce to JSON type, after that to array, and mapping json array to album array
                completionHandler(JSON(responce.value!)["results"].arrayValue.map{Album(album: $0)})// useing closure to exit from function
            } else {
            errorCallback( NSError(domain: "Internal server error", code: 1002, userInfo: nil) )// useing closure to exit from function
            }
        }
        
    }
    
    
    func getSongsByAlbum(albumId: Int, completionHandler: @escaping ([Track]) -> (Void), errorCallback: @escaping (_ error: Error) -> (Void)){
        Alamofire.request(searchSongsByAlbum, method: .get, parameters: ["country": localeCode!, "id": albumId]).responseJSON{
            responce in
            if responce.response?.statusCode == 200 {// error handling on responce
                // at first, we transforming responce to JSON type, after that to array, and mapping json array to track array
                completionHandler(JSON(responce.value!)["results"].arrayValue.map{Track(track: $0)})// usein closure to exit from function
            } else {
                errorCallback( NSError(domain: "Internal server error", code: 1002, userInfo: nil) )// usein closure to exit from function
            }
        }
        
    }
}
