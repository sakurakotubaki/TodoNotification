//
//  InfoHelper.swift
//  ToDo
//
//  Created by 橋本純一 on 2022/01/13.
//

import Foundation
import RealmSwift
import NotificationCenter

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
        // ここでsetNotificationのメソッドをしようする,setNotification(item: item)とかくとエラー出る!
        setNotification(item)
    }
    
    // dateをString型に変換
    func dateToString(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter.string(from:date)
    }
    
    // 通知の設定
    func setNotification(_ item:TodoItem){
        let targetDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],from: item.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate,repeats: false)
        let content = UNMutableNotificationContent()
        content.title = item.title
        content.sound = .default
        let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
