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
