//
//  Item.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2023/02/23.
//

import Foundation

struct Item: Codable{
    var id: Bool = true  //책, 영화
    var title: String = ""
    var description: String = ""
    var image: String = ""
    var author: String = ""
    
    var isbn: String = ""
    var link: String = ""
    var pubdate: String = ""
    var publisher: String = ""
    
    var updateDay: String = ""
    var score: Double = 0.00
    var like: Int = 0
    var isUpdate: Bool = false
    var isStop: Bool = false
    var isIncrease: Bool = false
    var recentUploadDate: Date = Date.now
    
}
