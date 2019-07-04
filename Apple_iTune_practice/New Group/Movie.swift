//
//  App.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/20.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var name: String
    var description: String
    var artist: String
    var hour: Int
    var minute: Int
    var artworkUrl: URL?
    var trackViewUrl: URL?
    
    private struct APIKeys {
        static let name = "trackName"
        static let description = "longDescription"
        static let artist = "artistName"
        static let artworkURL = "artworkUrl100"
        static let timeMillis = "trackTimeMillis"
        static let trackViewURL = "trackViewUrl"
    }
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary[APIKeys.name] as? String,
            let artworkURLString = dictionary[APIKeys.artworkURL] as? String,
            let artistName = dictionary[APIKeys.artist] as? String,
            let description = dictionary[APIKeys.description] as? String,
            let timeMillis = dictionary[APIKeys.timeMillis] as? Int,
            let trackURL = dictionary[APIKeys.trackViewURL] as? String
            else {
                return nil
        }
        
        self.name = name
        self.description = description
        self.artist = artistName
        self.artworkUrl = URL(string: artworkURLString)
        self.trackViewUrl = URL(string: trackURL)
        
        let time = timeMillis/60000
        self.hour = time/60
        self.minute = time % 60
        
    }
}
