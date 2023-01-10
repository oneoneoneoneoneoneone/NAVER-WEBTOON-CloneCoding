//
//  LocalNetwork.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/28.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class LocalNetwork{
    private let session: URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    //var dataTasks = [URLSessionDataTask]()
    //var bookList = [Book]()
    var itemList = [Item]()
    var query = ""
    
    func getLocation(by querys: [String]) -> [Item]{
        
        for query in querys{
            guard let url = api.getLocation(path: "", by: query).url else {
                print("ERROR")
                return itemList
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("hpNnarQFrSfzCnJzSUH2", forHTTPHeaderField: "X-Naver-Client-Id")
            request.setValue("DUf7UK6QHq", forHTTPHeaderField: "X-Naver-Client-Secret")
            
            
//            AF.request(url, method: .get, parameters: ["query":query], encoding: URLEncoding.default, headers: ["X-Naver-Client-Id": "hpNnarQFrSfzCnJzSUH2", "X-Naver-Client-Secret":"DUf7UK6QHq"])
//                .validate(statusCode: 200..<300)
//                .responseDecodable(of: Books.self){ response in
//                switch response.result{
//                case .success:
//                    let books = response.value //else {return}//try? JSONDecoder().decode([Books].self, from: response.data!)
//                case .failure:
//                    print("Error")
//                }
//            }
        //}
            
            
            URLSession.shared.dataTask(with: request){[weak self] data, response, error in
                guard error == nil,
                      let self = self else{
                    print("ERROR")
                    return
                }
                guard let response = response as? HTTPURLResponse else{
                    print("ERROR")
                    return
                }
                guard let data = data,
                      let books = try? JSONDecoder().decode([Books].self, from: data)
                else{
                    print("ERROR")
                    return
                }
                
                switch response.statusCode{
                case(200...299) : do {
                    let book = books.first!

                    var item: Item!

                    item.title = book.items.first!.title
                    item.description = book.items.first!.description
                    item.image = book.items.first!.image
                    item.author = book.items.first!.author
                    item.link = book.items.first!.link
                    item.pubdate = book.items.first!.pubdate
                    item.isbn = book.items.first!.isbn
                    item.updateDay = ""
                    item.score = 9.99
                    item.isUpdate = false
                    item.isStop = true
                    item.isIncrease = true

                    self.itemList.append(item)
                }
                case(400...499):
                    print("""
                        ERROR: Client ERROR \(response.statusCode)
                        Response: \(response)
                        """)
                case(500...599):
                    print("""
                        ERROR: Server ERROR \(response.statusCode)
                        Response: \(response)
                        """)
                default:
                    print("""
                        ERROR: \(response.statusCode)
                        Response: \(response)
                        """)
                }
                
            }.resume()
            
        }
        return itemList
    }
}
