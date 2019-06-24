//
//  MusicCollectionViewCell.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/21.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackView: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timeMillis: Int = 0
    var url: URL?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        guard let track = trackName.text,
            let  artistName = artistName.text,
            let collection = collectionName.text,
            let imageURL = url else { return }
        
        let dic = ["trackName": track,
                   "artistName": artistName,
                   "collectionName": collection,
                   "artworkUrl100": String(describing: imageURL),
                   "trackTimeMillis": timeMillis] as [String : Any]
        
        if let music: Music = Music(dictionary: dic) {
            
            if let savedMovie = UserDefaults.standard.object(forKey: "music") as? Data {
                
                if let loadedMusic = try? PropertyListDecoder().decode([Music].self, from: savedMovie) {
                    
                    var saved = loadedMusic
                    
                    saved.append(music)
                    
                    UserDefaults.standard.set( try? PropertyListEncoder().encode(saved),
                                               forKey: "music")
                }
                
            } else {
                
                var saved = [Music]()
                
                saved.append(music)
                
                UserDefaults.standard.set( try? PropertyListEncoder().encode(saved),
                                           forKey: "music")
                
            }
            
        }
        
        NotificationCenter.default.post(name: .savedItemChanged, object: nil)
        
    }

    func setupWith(imageURL: URL,
                   track: String,
                   artist: String,
                   collection: String,
                   hour: Int,
                   minute: Int) {
        
        trackName.text = track
        artistName.text = artist
        collectionName.text = collection
        
        url = imageURL
        timeMillis = hour * 3600000 + minute * 60000
        
        if hour == 0 {
            timeLabel.text = "\(minute) Minutes"
        } else {
            timeLabel.text = "\(hour) Hour \(minute) Minutes"
        }
        
        let request = URLRequest(url: imageURL)
        let networkProcessor = NetworkProcessor(request: request)
        
        networkProcessor.downloadData(completion: { (data, response, error) in
            
            DispatchQueue.main.async { [weak self] in
                
                if let imageData = data {
                    
                    self?.trackView?.image = UIImage(data: imageData)
                    
                }
            }
            
        })
    }

}
