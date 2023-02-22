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
        items = Repository.getItemsData()
        
        if items.count == 0 {
            let list = Const.Util.getItemTitleList()
            items = LocalNetwork().getLocation(id: "book", by: list.first!)
//            getLocation(id: "movie", by: list.last!)
            
            Repository.setItemsData(data: items)
        }
    }
}
