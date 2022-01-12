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
    
    // スワイプできるようにする
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    // 削除の操作がされた時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            InfoHelper().deleteItem(item: itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
                                    
                                    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = itemList[indexPath.row]
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = InfoHelper().dateToString(date: item.date)
        return cell!
    }
    
}

