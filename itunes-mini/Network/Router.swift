//
//  Router.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation

enum APIURL {
    case search(term: String)
    
    var scheme: String {
        return "https"
    }
     var host: String {
        return "itunes.apple.com"
    }
    var path: String {
        return "/search"
    }
    
    var parameter: [URLQueryItem]  {
        switch self {
        case .search(let term):
            return [URLQueryItem(name: "parameterkeyvalue", value: nil),
                    URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "country", value: "KR"),
                    URLQueryItem(name: "media", value: "software")]
        }
    }
}

