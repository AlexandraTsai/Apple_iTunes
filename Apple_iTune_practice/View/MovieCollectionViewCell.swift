//
//  MovieCollectionViewCell.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/20.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackView: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var timeMillis: Int = 0
    var url: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 20
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        guard let track = trackName.text,
            let  description = descriptionLabel.text,
            let  artistName = artistName.text,
            let imageURL = url else { return }
        
        let dic = ["trackName": track,
                   "longDescription": description,
                   "artistName": artistName,
                   "artworkUrl100": String(describing: imageURL),
                   "trackTimeMillis": timeMillis] as [String : Any]
        
        if let movie: Movie = Movie(dictionary: dic) {
            
            print(movie)
            
//            let savedArray = UserDefaults.standard.array(forKey: "movie") as? [Movie] ?? [Movie]()
            
            if let savedMovie = UserDefaults.standard.object(forKey: "movie") as? Data {
                
                if let loadedMovie = try? PropertyListDecoder().decode([Movie].self, from: savedMovie) {
                    
                    print("====================")
                    print(loadedMovie)
                    
                    var saved = loadedMovie
                    
                    saved.append(movie)
                    
                    UserDefaults.standard.set( try? PropertyListEncoder().encode(saved),
                                               forKey: "movie")
                }
                
            } else {
                
                print("----------CREAT------------")
                
                var saved = [Movie]()
                
                saved.append(movie)
                
                UserDefaults.standard.set( try? PropertyListEncoder().encode(saved),
                                           forKey: "movie")
                
            }
            
        }
        
    }
    
    func setupWith(imageURL: URL,
                   track: String,
                   artist: String,
                   collection: String,
                   hour: Int,
                   minute: Int,
                   description: String) {
        
        trackName.text = track
        artistName.text = artist
        collectionName.text = collection
        descriptionLabel.text = description
        
        timeMillis = hour * 3600000 + minute * 60000
        url = imageURL
        
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
