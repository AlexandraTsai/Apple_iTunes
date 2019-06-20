//
//  AppStoreClient.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/20.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import Foundation

struct AppStoreClient {
    func fetchApps(withTerm term: String, inMedia media: String, completion: @escaping ([App]?) -> Void)
    {
        print("2")
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
                let apps = resultDictionaries.flatMap({ appDictionary in
                    return App(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(apps)
            }
        }
    }
}
