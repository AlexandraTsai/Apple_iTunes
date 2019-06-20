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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 20
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
