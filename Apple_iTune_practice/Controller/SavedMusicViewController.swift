//
//  SavedMusicViewController.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/23.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class SavedMusicViewController: UIViewController {

    @IBOutlet weak var savedCollectionView: UICollectionView! {
    
        didSet {
        
            savedCollectionView.delegate = self
            savedCollectionView.dataSource = self
        
            let nib = UINib(nibName: String(describing: MusicCollectionViewCell.self), bundle: nil)
            savedCollectionView.register(nib,
                                         forCellWithReuseIdentifier: String(describing: MusicCollectionViewCell.self))
        
        }
    }
    
    var mode: ContentMode? {
    
        didSet {
        
            if let collectionView = savedCollectionView {
                collectionView.reloadData()
            
            }
        }
    }
    
    var musics = [Music]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchSavedMusics()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    func fetchSavedMusics() {
    
        if let savedMusic = UserDefaults.standard.object(forKey: "music") as? Data {
        
            if let loadedMusic = try? PropertyListDecoder().decode([Music].self, from: savedMusic) {
            
                musics = loadedMusic
            
            }
        }
    
    }

}

extension SavedMusicViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return musics.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MusicCollectionViewCell.self), for: indexPath)
        
        guard let musicCell = cell as? MusicCollectionViewCell else { return cell }
        
        let currentMusic = musics[indexPath.item]
        
        guard let url = currentMusic.artworkUrl else { return cell }
        
        musicCell.setupWith(imageURL: url,
                            track: currentMusic.name,
                            artist: currentMusic.artist,
                            collection: currentMusic.collection,
                            hour: currentMusic.hour,
                            minute: currentMusic.minute)
        
        return musicCell
    }
    
}

extension SavedMusicViewController: UICollectionViewDelegate {
    
}

extension SavedMusicViewController: UICollectionViewDelegateFlowLayout {
    
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

