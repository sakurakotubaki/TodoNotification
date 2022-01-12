//
//  ViewController.swift
//  ToDo
//
//  Created by 橋本純一 on 2022/01/12.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // Realmからデータを読み込む
    var itemList:Results<TodoItem>!
    // レルムのインスタンスが必要
    let realm = try! Realm()
    // データベースに変更があった場合に再読み込み
    var token:NotificationToken!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 日付順に並べ替え
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
        token = realm.observe { notification, realm in
            // 変更があった場合にここが実行される。,@IBOutlet weak var tableView: UITableView!が必要
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = itemList[indexPath.row].title
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        cell?.detailTextLabel?.text = formatter.string(from: itemList[indexPath.row].date)
        return cell!
    }
    
}

