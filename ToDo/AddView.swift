//
//  AddView.swift
//  ToDo
//
//  Created by 橋本純一 on 2022/01/12.
//

import UIKit
import RealmSwift

class AddView: UIViewController {
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // レルムをインスタンス化
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // DatePickerの地域設定
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale.current
    }
    
    @IBAction func onAdd(_ sender: Any) {
        //  モデルクラスのインスタンスを作り、データを設定します。
        //  このインスタンスをRealmに保存します。
//        let item = TodoItem()
//        item.title = itemField.text!
//        item.date = datePicker.date
//        item.id = String(Int.random(in: 0...9999))
//        try! realm.write {
//           realm.add(item)
//        }
        
        // InfoHelperに置き換える
        InfoHelper().save(title: itemField.text!, date: datePicker.date)
//        // 追加画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
}
