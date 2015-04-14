//
//  HBGroupCell.swift
//  HBHorizontalTableView
//
//  Created by 黄招宇 on 15/3/29.
//  Copyright (c) 2015年 Huang Zhaoyu. All rights reserved.
//

import UIKit

class HBGroupCell: UITableViewCell, HBTableViewDelegate {

    var apps = Array<Dictionary<String, String>>()
    
    @IBOutlet weak var groupNameLabel: UILabel!
    var horizontalTableView: HBHorizontalTableView!
    
    @IBAction func showAllButton(sender: UIButton) {
        UIAlertView(title: "Show All", message: "created by 黄招宇", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func configureCell(group: Dictionary<String, Array<Dictionary<String, String>>>) {
        let htv = HBHorizontalTableView(frame: CGRectMake(0, 44, self.contentView.bounds.width, 178))
        htv.delegate = self
        contentView.addSubview(htv)
        horizontalTableView = htv
        
        groupNameLabel.text = group["about"]![0]["name"]
        apps = group["apps"]!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("group_cell -> awakeFromNib")
    }
    
    
    // MARK: Horizontal TableView Delegate
    
    func numberOfSectionsInTableView(horizontalTableView: HBHorizontalTableView) -> Int {
        return 1
    }
    
    func tableView(horizontalTableView: HBHorizontalTableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(horizontalTableView: HBHorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(horizontalTableView: HBHorizontalTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HBAppCell = horizontalTableView.tableView!.dequeueReusableCellWithIdentifier("app_cell", forIndexPath: indexPath) as! HBAppCell
        cell.configureCell(apps[indexPath.row])
        return cell
    }
    
    func tableView(horizontalTableView: HBHorizontalTableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row -> \(indexPath.row)")
        horizontalTableView.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
