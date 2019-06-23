//
//  SavedDetailViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/22.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class SavedDetailViewController: UIViewController {

    @IBOutlet weak var savedCollectionView: UICollectionView! {
        
        didSet {
            
            savedCollectionView.delegate = self
            savedCollectionView.dataSource = self
            
            let nib = UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil)
            savedCollectionView.register(nib,
                                         forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
            
            let nib2 = UINib(nibName: String(describing: MusicCollectionViewCell.self), bundle: nil)
            savedCollectionView.register(nib2,
                                         forCellWithReuseIdentifier: String(describing: MusicCollectionViewCell.self))
            
        }
    }
    
    var movies = [Movie]()
    var musics = [Music]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSavedMovies()
        fetchSavedMusics()

    }
    
    func fetchSavedMovies() {
        
        if let savedMovie = UserDefaults.standard.object(forKey: "movie") as? Data {
            
            if let loadedMovie = try? PropertyListDecoder().decode([Movie].self, from: savedMovie) {
                
                movies = loadedMovie
                
            }
        }
        
    }

    func fetchSavedMusics() {
        
        if let savedMovie = UserDefaults.standard.object(forKey: "music") as? Data {
            
            if let loadedMusic = try? PropertyListDecoder().decode([Music].self, from: savedMovie) {
                
                musics = loadedMusic
                
            }
        }
        
    }

}

extension SavedDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath)
        
        guard let movieCell = cell as? MovieCollectionViewCell else { return cell }
        
        let currentMovie = movies[indexPath.item]
        
        guard let url = currentMovie.artworkUrl else { return cell }
        
        movieCell.setupWith(imageURL: url,
                            track: currentMovie.name,
                            artist: currentMovie.artist,
                            collection: "collection",
                            hour: currentMovie.hour,
                            minute: currentMovie.minute,
                            description: currentMovie.description)
        
        return movieCell
    }
    
}

extension SavedDetailViewController: UICollectionViewDelegate {
    
}

extension SavedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width - 10, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
}
