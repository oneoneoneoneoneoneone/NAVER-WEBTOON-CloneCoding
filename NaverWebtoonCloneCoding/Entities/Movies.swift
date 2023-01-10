//
//  Movies.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/04.
//

import Foundation

struct Movies: Codable{
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Movie]
}

struct Movie: Codable{
    let title: String
    let subtitle: String
    let image: String
    let director: String
    let link: String
    let pubdate: String
    let isbn: String
    
    let userRating: String
    let actor: String
}
