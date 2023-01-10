//
//  User.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/02.
//

import Foundation

struct User: Codable{
    let id: String
    let cookieQty: Int
    var likeItems: [LikeItem] = []   //관심웹툰
    //최근 본
    //임시저장
    //댓글
}

struct LikeItem: Codable{
//    var item: Item = Item()
    var isbn: String
    var title: String
    var addDate: Date = Date.now
    var isAlarm: Bool = true
}
