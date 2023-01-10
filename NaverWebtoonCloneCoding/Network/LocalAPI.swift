//
//  LocalAPI.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/28.
//

import Foundation

struct LocalAPI{
    static let scheme = "https"
    static let host = "openapi.naver.com"
    
    func getLocation(path: String, by query: String) -> URLComponents{
        var components = URLComponents()
        components.scheme = LocalAPI.scheme
        components.host = LocalAPI.host
        components.path = "/v1/search/\(path).json"
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
//            URLQueryItem(name: "radius", value: "500"),
//            URLQueryItem(name: "sort", value: "distance"),
        ]
        
        return components
    }
}
