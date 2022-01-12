//
//  TodoItem.swift
//  ToDo
//
//  Created by 橋本純一 on 2022/01/12.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}
