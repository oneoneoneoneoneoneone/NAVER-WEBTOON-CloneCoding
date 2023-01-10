//
//  TabViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/07.
//

import UIKit

class TabViewController: UITabBarController {
    var items: [Item] = []
    
    lazy var calendarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "웹툰"
        item.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        item.selectedImage = UIImage(systemName: "calendar.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        return item
    }()
    
    lazy var endItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "추천완결"
        item.image = UIImage(systemName: "book", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        item.selectedImage = UIImage(systemName: "book.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        return item
    }()
    
    lazy var starItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "베스트도전"
        item.image = UIImage(systemName: "star.square", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        item.selectedImage = UIImage(systemName: "star.square.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        return item
    }()
    
    lazy var smileItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "MY"
        item.image = UIImage(systemName: "face.smiling", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        item.selectedImage = UIImage(systemName: "face.smiling.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        return item
    }()
    
    lazy var addItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "더보기"
        item.image = UIImage(systemName: "rectangle.grid.2x2", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        item.selectedImage = UIImage(systemName: "rectangle.grid.2x2.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        
        view.backgroundColor = .systemBackground
        view.tintColor = .label
        
        let calendarViewController = MainNavigationView(rootViewController: MainViewController())//MainNavigationView(rootViewController: MainViewController())
        calendarViewController.tabBarItem = calendarItem
        
        let endViewController = UINavigationController(rootViewController: EndViewController())
        endViewController.tabBarItem = endItem
        
        let starViewController = UINavigationController(rootViewController: BestViewController())
        starViewController.tabBarItem = starItem
        
        let smileViewController = UINavigationController(rootViewController: MyViewController())
        smileViewController.tabBarItem = smileItem
        
        let addViewController = UINavigationController(rootViewController: AddViewController())
        addViewController.tabBarItem = addItem
        
        viewControllers = [calendarViewController, endViewController, starViewController, smileViewController, addViewController]
        
        tabBarController?.selectedIndex = 0
        
        getData()
    }
    
    private func getData(){
        items = Const.Util.getItemsData()
        
        if items.count == 0 {
            let list = Const.Util.getItemTitleList()
            getLocation(id: "book", by: list.first!)
//            getLocation(id: "movie", by: list.last!)
            
            Const.Util.setItemsData(data: items)
        }
    }
    
    
    func getLocation(id: String, by querys: [String]){//, day: Int){
        let api = LocalAPI()
        self.items = []
        
        for query in querys{
            guard let url = api.getLocation(path: id, by: query).url else {
                print("ERROR")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("hpNnarQFrSfzCnJzSUH2", forHTTPHeaderField: "X-Naver-Client-Id")
            request.setValue("DUf7UK6QHq", forHTTPHeaderField: "X-Naver-Client-Secret")
            
            sleep(1)
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
                    guard let data = data
                    else{
                        print("data ERROR")
                        return
                    }

                    switch response.statusCode{
                    case(200...299) : do {
//
//                        if id == "book"{
                        let books = try JSONDecoder().decode(Books.self, from: data)
                        
                        var item = Item()
                            
                        item.id = Bool.random()
                        item.title = books.items.first!.title
                        item.description = books.items.first!.description
                        item.image = books.items.first!.image
                        item.author = books.items.first!.author
                        item.link = books.items.first!.link
                        item.pubdate = books.items.first!.pubdate
                        item.publisher = books.items.first!.publisher
                        item.isbn = books.items.first!.isbn
                        item.updateDay = ["월", "화", "수", "목", "금", "토", "일"].randomElement()!//"\(Int.random(in: 0..<11))"
                        item.score = round(Double.random(in: 0...10) * 100)/100
                        item.like = Int.random(in: 0...999999)
                        item.isUpdate = Bool.random()
                        item.isStop = Bool.random()
                        item.isIncrease = Bool.random()
                        
                        self.items.append(item)
//                        }
//                        else{
//                            let movies = try JSONDecoder().decode(Movies.self, from: data)
//
//                            var item = Item()
//
//                            item.id = false
//                            item.title = movies.items.first!.title
//                            item.description = movies.items.first!.subtitle
//                            item.image = movies.items.first!.image
//                            item.author = movies.items.first!.director
//                            item.link = movies.items.first!.link
//                            item.pubdate = movies.items.first!.pubdate
//                            item.publisher = movies.items.first!.publisher
//                            item.isbn = movies.items.first!.isbn
//                            //item.updateDay = ["월", "화", "수", "목", "금", "토", "일"].randomElement()!//"\(Int.random(in: 0..<11))"
//                            item.score = round(Double.random(in: 0...10) * 100)/100
//                            item.like = Int.random(in: 0...999999)
//                            item.isUpdate = Bool.random()
//                            item.isStop = Bool.random()
//                            item.isIncrease = Bool.random()
//
//                            self.items.append(item)
//                        }
                    }
                    case(400...499):
                        let error = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: Client ERROR \(response.statusCode)
                            ERROR Message: \(error.errorMessage)
                            """)
                    case(500...599):
                        _ = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: Server ERROR \(response.statusCode)
                            Response: \(response)
                            """)
                    default:
                        _ = try JSONDecoder().decode(Error.self, from: data)
                        print("""
                            ERROR: \(response.statusCode)
                            Response: \(response)
                            """)
                    }
                }catch(let error) {
                    print("URLSession Error - \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    

}


