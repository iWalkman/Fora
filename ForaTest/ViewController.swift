//
//  ViewController.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 26/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//        self.searchController.searchResultsUpdater = self
//        self.searchController.delegate = self
//        self.searchController.searchBar.delegate = self
//
//        self.searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.dimsBackgroundDuringPresentation = true
//        self.searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.sizeToFit()
//
//        searchController.searchBar.becomeFirstResponder()
//
//        self.navigationItem.titleView = searchController.searchBar
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search albums"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        //navigationItem.searchController = searchController
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        ApiWorker.shared.getAlbumsBySearch(albumName: searchController.searchBar.text!){
            albums  in
            self.albums = albums
            self.collectionView.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
        cell.initialize(album: albums[indexPath.row])
        
        return cell
    }

}
