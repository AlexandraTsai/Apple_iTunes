//
//  ViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/19.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
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
            
            let nib2 = UINib(nibName: String(describing: MusicCollectionViewCell.self), bundle: nil)
            resultCollectionView.register(nib2, forCellWithReuseIdentifier: String(describing: MusicCollectionViewCell.self))
            
            resultCollectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
            
        }
    }
    
    var movies: [Movie]?
    var musics: [Music]?
    var appStoreClient = AppStoreClient()
    var term: String = "" {
        
        didSet {
            
             fetchApps()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultCollectionView.alpha = 0
    }
    
    func fetchApps() {
        
        appStoreClient.fetchMovie(withTerm: term, inMedia: "movie", completion: { (movie) in
            
            self.movies = movie
            
            if movie?.count != 0 {
                 self.resultCollectionView.alpha = 1
            }
           
            self.resultCollectionView.reloadData()
            
        })
        
        appStoreClient.fetchMusic(withTerm: term, inMedia: "music", completion: { (music) in
            
            self.musics = music
            
            if music?.count != 0 {
                
                self.resultCollectionView.alpha = 1
            }
            
            self.resultCollectionView.reloadData()
            
        })
        
    }

}

extension SearchViewController: UICollectionViewDataSource {

    func numberOfSections(in: UICollectionView) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            
            guard let movies = movies else { return 0}
            
            return movies.count
        
        default:
            
            guard let musics = musics else { return 0}
            
            return musics.count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath)
            guard let movieCell = cell as? MovieCollectionViewCell else { return cell }
            
            let app = movies?[indexPath.row]
            
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
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MusicCollectionViewCell.self), for: indexPath)
            guard let movieCell = cell as? MusicCollectionViewCell else { return cell }
           
            guard let musics = musics else {return cell}
            
            let app = musics[indexPath.row]
            
            if let imageURL = app.artworkUrl {
                
                movieCell.setupWith(imageURL: imageURL,
                                    track: app.name,
                                    artist: app.artist,
                                    collection: app.collection,
                                    hour: app.hour,
                                    minute: app.minute)
            }
            
            return movieCell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        
        guard let headerCell = cell as? CollectionReusableView else { return cell }
        
        switch indexPath.section {
        case 0:
            headerCell.sectionHeaderLabel.text = "電影"
        default:
            headerCell.sectionHeaderLabel.text = "音樂"
        }
        
        headerCell.sectionHeaderLabel.textColor = ALColor.c2
        
        return headerCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: resultCollectionView.bounds.width, height: 50)
        
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 10, height: 200)
            
        default:
            return CGSize(width: UIScreen.main.bounds.width - 10, height: 150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            term = text
        }
        
    }

}
