//
//  MainContent.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/11/04.
//

import Foundation

struct MainContent: Codable{
    let day: Int
    let data: [Data]
    
}

struct Data: Codable{
    let sectionType: SectionType
    let query: [String]

}
