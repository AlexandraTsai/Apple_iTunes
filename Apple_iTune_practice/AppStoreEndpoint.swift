//
//  AppStoreEndpoint.swift
//  Apple_iTune_practice
//
//  Created by 蔡佳宣 on 2019/6/20.
//  Copyright © 2019 蔡佳宣. All rights reserved.
//

import Foundation

enum AppStoreEndpoint
{
    case search(term: String, media: String)
    
    var request: URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    private var path: String {
        switch self {
        case .search: return "/search"
        }
    }
    
    private struct ParameterKeys {
        static let term = "term"
        static let media = "media"
    }
    
    private struct DefaultValues {
        static let term = "apple"
    }
    
    // ["term" : "instagram", "media" : "software", "country" : "us"]
    private var parameters: [String : Any] {
        switch self {
        case .search(let term, let media):
            let parameters: [String : Any] = [
                ParameterKeys.term : term,
                ParameterKeys.media : media
            ]
            
            return parameters
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
}
