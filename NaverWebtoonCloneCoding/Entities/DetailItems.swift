//
//  DetailTableViewCellData.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/11.
//

import Foundation

struct DetailItems: Codable{
    let isbn: String
    let title: String
    let detailData: [DetailData]
}

struct DetailData: Codable{
    var title: String = "1화"
    var thumbnailImage: String = ""
    var score: Double = 0.00
    var uploadDate: Date = Date.now
    var price: Int = 2
}
