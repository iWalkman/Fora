//
//  PresentationOfAlbumTableViewController.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 28/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit
import SwiftyJSON


class PresentationOfAlbumTableViewController: UITableViewController{
    
    
    var album : Album?
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        ApiWorker.shared.getSongsByAlbum(albumId: (album?.collectionId)!, completionHandler:  {             tracks in
                    self.tracks = tracks
                    self.tracks.remove(at: 0)//removing existing album info
                    self.tableView.reloadData()} )
        { error in
            self.showAlertOfNilSearchResult(titleOfAlert: "Can not download songs, try later")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 1
        }
        return tracks.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return CGFloat(UIScreen.main.bounds.width * 0.45)
        }

        return CGFloat(UIScreen.main.bounds.width * 0.1)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumInfoTableViewCell
            cell?.initialize(album: self.album!)
            return cell!
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TracksTableViewCell
        cell?.initialize(track: tracks[indexPath.row])
        return cell!
    }
    
    func showAlertOfNilSearchResult(titleOfAlert: String){
        let alert = UIAlertController(title: titleOfAlert, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
 

}
