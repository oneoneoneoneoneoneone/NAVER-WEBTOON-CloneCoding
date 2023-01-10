//
//  Content.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/25.
//

import Foundation

//struct Content: Decodable{
//    let days: [Day]
//    let bannar: [Item]
//}

struct Content: Codable{
    let day: String
    let data: [CalendarContent]
    
}

struct CalendarContent: Codable{
    let sectionType: SectionType
    let contentItem: [Item]

}

enum SectionType: String, Codable{
    case basic, ai, rank, update
    
    var identifier: String{
        switch self {
        case .basic:
            return "CalendarBasicViewCell"
        case .ai:
            return "CalendarAiViewCell"
        case .rank:
            return "CalendarRankViewCell"
        case .update:
            return "CalendarUpdateViewCell"
        }
    }
}

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
