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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        ApiWorker.shared.getAlbumsBySearch(albumName: searchController.searchBar.text!){
            albums  in
            
            if albums.count == 0 {
                self.showAlertOfNilSearchResult()
            }
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PresentationOfAlbumTableViewController{
            let index = self.collectionView.indexPathsForSelectedItems?.first![1]
            destinationVC.album = albums[index!]
        }
    }
    
    
    func showAlertOfNilSearchResult(){
        let alert = UIAlertController(title: "Nothing fing", message: "", preferredStyle: .alert)
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
