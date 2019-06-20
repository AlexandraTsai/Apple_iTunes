//
//  ViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/19.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var resultCollectionView: UICollectionView! {
        
        didSet {
            
            resultCollectionView.dataSource = self
            resultCollectionView.delegate = self
            
            let nib = UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil)
            resultCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
            
        }
    }
    
    var apps: [App]?
    var appStoreClient = AppStoreClient()
    var term: String = "" {
        
        didSet {
            
             fetchApps()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func fetchApps() {
        
        appStoreClient.fetchApps(withTerm: term, inMedia: "movie", completion: { (apps) in
            
            self.apps = apps
            self.resultCollectionView.reloadData()
            
        })
        
    }

}

extension ViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let apps = apps {
            return apps.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath)
        guard let movieCell = cell as? MovieCollectionViewCell else { return cell }
        
        let app = apps?[indexPath.row]
        
        if let imageURL = app?.artworkUrl,
            let track = app?.name,
            let artist = app?.artist,
            let hour = app?.hour,
            let min = app?.minute,
            let description = app?.description {
            
            movieCell.setupWith(imageURL: imageURL,
                                track: track,
                                artist: artist,
                                collection: "CollectionName",
                                hour: hour,
                                minute: min,
                                description: description)
        }
        
        return movieCell
        
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 10, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            term = text
        }
        
    }

}
