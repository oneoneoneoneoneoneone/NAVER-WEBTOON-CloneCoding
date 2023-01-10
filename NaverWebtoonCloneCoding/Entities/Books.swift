//
//  Book.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/05.
//

import Foundation

struct Books: Codable{
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Book]
}

struct Book: Codable{
    let title: String
    let description: String
    let image: String
    let author: String
    let link: String
    let pubdate: String
    let isbn: String
    
    let discount: String
    let publisher: String
    
}

struct Error: Codable{
    let errorMessage: String
    let errorCode : String
    
}
