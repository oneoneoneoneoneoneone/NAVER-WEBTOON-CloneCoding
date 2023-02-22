//
//  LocalNetwork.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/28.
//

import Foundation
import UIKit
import SnapKit

class LocalNetwork{
    let api = LocalAPI()
    
    func getLocation(id: String, by querys: [String]) -> [Item]{
        var items: [Item] = []
        
        for query in querys{
            guard let url = api.getLocation(path: id, by: query).url else {
                print("ERROR")
                return items
            }
            
            //리퀘스트 생성
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(APIKey().X_Naver_Client_Id, forHTTPHeaderField: "X-Naver-Client-Id")
            request.setValue(APIKey().X_Naver_Client_Secret, forHTTPHeaderField: "X-Naver-Client-Secret")
            
            sleep(1)
            //태스크 생성
            URLSession.shared.dataTask(with: request){[weak self] data, response, error in
                do{
                    guard error == nil,
                          let self = self else{
                        print("ERROR")
                        return
                    }
                    guard let response = response as? HTTPURLResponse else{
                        print("response ERROR")
                        return
                    }
                    guard let data = data else{
                        print("response ERROR")
                        return
                    }
                    
                    switch response.statusCode{
                    case(200...299) :
                        do {
                            let books = try JSONDecoder().decode(Books.self, from: data)
                            guard let book = books.items.first else{ return }
                            
                            var item = Item()
                            
                            item.id = Bool.random()
                            item.title = book.title
                            item.description = book.description
                            item.image = book.image
                            item.author = book.author
                            item.link = book.link
                            item.pubdate = book.pubdate
                            item.publisher = book.publisher
                            item.isbn = book.isbn
                            item.updateDay = ["월", "화", "수", "목", "금", "토", "일"].randomElement() ?? "월"
                            item.score = round(Double.random(in: 0...10) * 100)/100
                            item.like = Int.random(in: 0...999999)
                            item.isUpdate = Bool.random()
                            item.isStop = Bool.random()
                            item.isIncrease = Bool.random()
                            
                            items.append(item)
                        }
                    case(400...499):
                        let error = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: Client ERROR \(response.statusCode)
                            ERROR Message: \(error.errorMessage)
                            """)
                        return
                    case(500...599):
                        _ = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: Server ERROR \(response.statusCode)
                            Response: \(response)
                            """)
                        return
                    default:
                        _ = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: \(response.statusCode)
                            Response: \(response)
                            """)
                        return
                    }
                }catch(let error) {
                    print("URLSession Error - \(error.localizedDescription)")
                    return
                }
                
            }
            //실행
            .resume()
        }
        
        return items
    }
}
