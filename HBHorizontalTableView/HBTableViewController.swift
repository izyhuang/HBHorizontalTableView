//
//  HBTableViewController.swift
//  HBHorizontalTableView
//
//  Created by 黄招宇 on 15/3/29.
//  Copyright (c) 2015年 Huang Zhaoyu. All rights reserved.
//

import UIKit

class HBTableViewController: UITableViewController {
    
    var groups = Array<Dictionary<String, Array<Dictionary<String, String>>>>()
    var apps = Array<Dictionary<String, String>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        loadData()
    }
    
    func loadData() {
        let dict0 = ["image":"calendar", "name":"calendar", "type":"儿童", "price":"0.00"]
        apps.append(dict0)
        
        let dict1 = ["image":"contacts", "name":"contacts", "type":"工具", "price":"1.00"]
        apps.append(dict1)
        
        let dict2 = ["image":"finder", "name":"finder", "type":"效率", "price":"2.00"]
        apps.append(dict2)
        
        let dict3 = ["image":"game-center", "name":"game-center", "type":"游戏", "price":"3.00"]
        apps.append(dict3)
        
        let dict4 = ["image":"health", "name":"health", "type":"健康", "price":"4.00"]
        apps.append(dict4)
        
        let dict5 = ["image":"healthbook", "name":"healthbook", "type":"健康", "price":"5.00"]
        apps.append(dict5)
        
        let dict6 = ["image":"ibook", "name":"ibook", "type":"图书", "price":"6.00"]
        apps.append(dict6)
        
        let dict7 = ["image":"icloud-drive", "name":"icloud-drive", "type":"效率", "price":"7.00"]
        apps.append(dict7)
        
        let dict8 = ["image":"passbook", "name":"passbook", "type":"生活", "price":"8.00"]
        apps.append(dict8)
        
        let dict9 = ["image":"preview", "name":"preview", "type":"效率", "price":"9.00"]
        apps.append(dict9)
        
        let dict10 = ["image":"reminders", "name":"reminders", "type":"效率", "price":"10.00"]
        apps.append(dict10)
        
        let dict11 = ["image":"spotlight", "name":"spotlight", "type":"工具", "price":"11.00"]
        apps.append(dict11)
        
        let dict12 = ["image":"textedit", "name":"textedit", "type":"效率", "price":"12.00"]
        apps.append(dict12)
        
        let dict13 = ["image":"tips", "name":"tips", "type":"参考", "price":"13.00"]
        apps.append(dict13)
        
        let group0 = ["about":[["name":"优秀新 App"]], "apps": apps]
        groups.append(group0)
        
        // 清空
        apps = []
        
        let dict14 = ["image":"angry-birds", "name":"angry-birds", "type":"游戏", "price":"25.00"]
        apps.append(dict14)
        
        let dict15 = ["image":"cut-the-rope", "name":"cut-the-rope", "type":"游戏", "price":"6.00"]
        apps.append(dict15)
        
        let dict16 = ["image":"early-bird", "name":"early-bird", "type":"游戏", "price":"16.00"]
        apps.append(dict16)
        
        let dict17 = ["image":"fruit-ninja", "name":"fruit-ninja", "type":"游戏", "price":"22.00"]
        apps.append(dict17)
        
        let dict18 = ["image":"plants-vs-zombies", "name":"plants-vs-zombies", "type":"游戏", "price":"30.00"]
        apps.append(dict18)
        
        let group1 = ["about":[["name":"优秀新游戏"]], "apps": apps]
        groups.append(group1)
    }
    
    func register() {
        tableView.registerClass(HBGroupCell.self, forCellReuseIdentifier: "group_cell")
        var cellNib: UINib = UINib(nibName: "HBGroupCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "group_cell")
    }
    
    
    // MARK: TableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240
    }
    
    // MARK: TableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HBGroupCell = tableView.dequeueReusableCellWithIdentifier("group_cell", forIndexPath: indexPath) as HBGroupCell
        cell.configureCell(groups[indexPath.row])
        return cell
    }
}
