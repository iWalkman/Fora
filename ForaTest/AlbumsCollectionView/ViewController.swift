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
        
        setCellSize()
    }
    
    func setCellSize(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let cellWidth = (UIScreen.main.bounds.width - 20) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.2)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){// implementation of UISearchBarDelegate to search by button click
        collectionView.isHidden = true// hide collection view for search
        activityIndicator.startAnimating()
        ApiWorker.shared.getAlbumsBySearch(albumName: searchController.searchBar.text!, completionHandler: { // get albums by request
            albums  in
            
            if albums.count == 0 {// if search fails show alert
                self.showAlertOfNilSearchResult(titleOfAlert: "Nothing found")
            }
            
            self.albums = albums.sorted { $0.collectionName < $1.collectionName }// sorting recived array alphabetically
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.collectionView.isHidden = false// show table view after request
            
            self.searchController.isActive = false // hides search controller
        } ) { error in
                self.showAlertOfNilSearchResult(titleOfAlert: "Network Error") // if recived error show alert
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// transfer date to album presentation view controller
        if let destinationVC = segue.destination as? PresentationOfAlbumTableViewController{
            let index = self.collectionView.indexPathsForSelectedItems?.first![1]
            destinationVC.album = albums[index!]
        }
    }
    
    
    func showAlertOfNilSearchResult(titleOfAlert: String){// show alert for errors
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
