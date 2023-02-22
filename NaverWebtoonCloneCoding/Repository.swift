//
//  Repository.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2023/02/23.
//

import Foundation


struct Repository{    
    static func getUserData() -> User!{
        guard let savedData = UserDefaults.standard.object(forKey: "user") as? Foundation.Data else {return nil}
        
        do{
            return try JSONDecoder().decode(User.self, from: savedData)
        }
        catch{
            print("UserData decode Error - \(error.localizedDescription)")
            return nil
        }
    }
    
    static func setUserData(data: User!) {
        do{
            let encoded = try JSONEncoder().encode(data)
            UserDefaults.standard.setValue(encoded, forKey: "user")
        }
        catch{
            print("UserData encode Error - \(error.localizedDescription)")
        }
    }
    
    static func getItemsData() -> [Item]{
        guard let savedData = UserDefaults.standard.object(forKey: "item") as? Foundation.Data else {return []}
        
        do{
            return try JSONDecoder().decode([Item].self, from: savedData)
        }
        catch{
            print("ItemData decode Error - \(error.localizedDescription)")
            return []
        }
    }
    
    static func setItemsData(data: [Item]) {
        do{
            let encoded = try JSONEncoder().encode(data)
            UserDefaults.standard.setValue(encoded, forKey: "item")
        }
        catch{
            print("ItemData encode Error - \(error.localizedDescription)")
        }
    }
    
    static func getItemData(isbn: String) -> Item!{
        return getItemsData().filter{$0.isbn == isbn}.first!
    }
    
    static func setItemData(data: Item) {
        do{
            var items = getItemsData()
            if items.firstIndex(where: {$0.isbn == data.isbn}) != nil{
                items.remove(at: items.firstIndex(where: {$0.isbn == data.isbn})!)
            }
            items.append(data)
            
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.setValue(encoded, forKey: "item")
        }
        catch{
            print("ItemData encode Error - \(error.localizedDescription)")
        }
    }
    
    static private func getDetailItemsData() -> [DetailItems]{
        guard let savedData = UserDefaults.standard.object(forKey: "detailItems") as? Foundation.Data else {return []}
        
        do{
            return try JSONDecoder().decode([DetailItems].self, from: savedData)
        }
        catch{
            print("ItemData decode Error - \(error.localizedDescription)")
            return []
        }
    }
    
    static func getDetailItemsData(isbn: String) -> DetailItems!{
        return getDetailItemsData().filter{$0.isbn == isbn}.first
    }
    
    static func setDetailItemsData(data: DetailItems) {
        do{
            var detailItems = getDetailItemsData()
            if detailItems.firstIndex(where: {$0.isbn == data.isbn}) != nil{
                detailItems.remove(at: detailItems.firstIndex(where: {$0.isbn == data.isbn})!)
            }
            detailItems.append(data)
            
            let encoded = try JSONEncoder().encode(detailItems)
            UserDefaults.standard.setValue(encoded, forKey: "detailItems")
        }
        catch{
            print("ItemData encode Error - \(error.localizedDescription)")
        }
    }
    
    static func getDetailData(day: String) -> [DetailData]{
        var detailData: [DetailData] = []
        let weekDay = Calendar.current.component(.weekday, from: Date.now)
        let thisWeek = Calendar.current.date(byAdding: DateComponents(day: Const.DateFormet.getWeekDay(day: day) - weekDay + 1), to: Date.now)
        
        for i in 1...10{
            var data = DetailData()
            data.thumbnailImage = "\(i).square.fill"
            data.title = "\(i)화"
            data.price = 2
            data.score = round(Double.random(in: 0...10) * 100)/100
            data.uploadDate = Calendar.current.date(byAdding: DateComponents(weekOfMonth: i - 7), to: thisWeek!)!
            
            detailData.append(data)
        }
        
        return detailData
    }
    
    static func getSearchLog() -> [String]{
        guard let savedData = UserDefaults.standard.object(forKey: "searchLog") as? [String] else {return []}
        
        return savedData
    }
    
    static func setSearchLog(data: [String]) {
        UserDefaults.standard.setValue(data, forKey: "searchLog")
    }
}
