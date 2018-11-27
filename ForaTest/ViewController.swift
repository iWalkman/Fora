//
//  ViewController.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 26/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search albums"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        activityIndicator.hidesWhenStopped = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        ApiWorker.shared.getAlbumsBySearch(albumName: searchController.searchBar.text!){
            albums  in
            self.albums = albums.sorted { $0.collectionName < $1.collectionName }
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.collectionView.isHidden = false
            
            self.searchController.isActive = false
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
