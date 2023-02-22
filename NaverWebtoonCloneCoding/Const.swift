//
//  Const.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import Foundation
import UIKit

struct Const{
    struct Color{
        static func reverseColor(color: UIColor) -> UIColor{
            let r: CGFloat = color.cgColor.components![0], g: CGFloat = color.cgColor.components![1], b: CGFloat = color.cgColor.components![2]
            return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: 1)
        }
    }
    
    struct Size{
        static var HeaderMaxHeight: CGFloat = 64.0
        static var HeaderMinHeight: CGFloat = 20.0
    }
    
    struct Layout{
        static var LeadingTrailingInset: CGFloat = 10.0
        static var Offset: CGFloat = 5.0
    }
    
    struct DateFormet{
        static func setDateToString(date: Date) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd"
            
            return dateFormatter.string(from: date)
        }
        
        static func setStringToDate(date: String) -> Date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd"
            
            return dateFormatter.date(from: date)!
        }
        
        static func getNumberOfDays(from: Date = Date.now, to: Date) -> Int{
            let calendar = NSCalendar.current
//            let fromDate = Calendar.startOfDay(for: from)
//            let toDate = Calendar.startOfDay(for: to)
            let numberOfDays = calendar.dateComponents([.day], from: from, to: to)
            
            return numberOfDays.day!
        }
        
        static func getWeekDay(day: String) -> Int{
            switch day{
            case "일": return 1
            case "월": return 2
            case "화": return 3
            case "수": return 4
            case "목": return 5
            case "금": return 6
            case "토": return 7
            default:  return 0
            }
        }
    }
        
    struct Number{
        static func setIntToString(number: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            return numberFormatter.string(from: NSNumber(value: number))!
        }
    }
    
    struct Alert{
        static func getDefaultAlert(title: String, message: String = "") -> UIAlertController{
            let resultAlert = UIAlertController(title: title, message: message == "" ? "\(title)를 선택하였습니다." : message, preferredStyle: .alert)
            
            resultAlert.addAction(UIAlertAction(title: "확인", style: .default))
            
            return resultAlert
        }
    }
    
    struct Util{
        static func getItemTitleList() -> [[String]]{
            guard let path = Bundle.main.path(forResource: "ItemTitleList", ofType: "plist"),
                  let data = FileManager.default.contents(atPath: path),
                  let list = try? PropertyListDecoder().decode([[String]].self, from: data) else {return []}
            
            return list
        }
    }
}
