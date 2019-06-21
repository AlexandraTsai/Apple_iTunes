//
//  AppStoreClient.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/20.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import Foundation

struct AppStoreClient {
    
    func fetchMovie(withTerm term: String, inMedia media: String, completion: @escaping ([Movie]?) -> Void) {
        
        // 1. endpoint
        let searchEndpoint = AppStoreEndpoint.search(term: term, media: media)
        let searchUrlRequest = searchEndpoint.request
        
        // 2. network processor
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let movies = resultDictionaries.compactMap({ appDictionary in
                    return Movie(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(movies)
            }
        }
    }
    
    func fetchMusic(withTerm term: String, inMedia media: String, completion: @escaping ([Music]?) -> Void) {
        
        let searchEndpoint = AppStoreEndpoint.search(term: term, media: media)
        let searchUrlRequest = searchEndpoint.request
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpResponse, error) in
            
            DispatchQueue.main.async {

                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                let musics = resultDictionaries.compactMap({ appDictionary in
                    return Music(dictionary: appDictionary)
                })
                
                completion(musics)
            }
        }
    }
}
