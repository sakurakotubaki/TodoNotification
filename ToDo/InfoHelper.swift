//
//  InfoHelper.swift
//  ToDo
//
//  Created by 橋本純一 on 2022/01/13.
//

import Foundation
import RealmSwift

class InfoHelper {
    
    let realm = try! Realm()
    
    func save(title:String,date:Date){
        let item = TodoItem()
        item.title = title
        item.date = date
        item.id = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item)
        }
    }
    
    // dateをString型に変換
    func dateToString(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter.string(from:date)
    }
    
}
