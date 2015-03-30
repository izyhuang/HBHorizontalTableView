//
//  HBAppCell.swift
//  HBHorizontalTableView
//
//  Created by 黄招宇 on 15/3/28.
//  Copyright (c) 2015年 Huang Zhaoyu. All rights reserved.
//

import UIKit

class HBAppCell: UITableViewCell {
    
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var app = Dictionary<String, String>()
    
    @IBAction func iconButtonDidClicked(sender: UIButton) {
        UIAlertView(title: app["name"], message: "created by 黄招宇", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func configureCell(app: Dictionary<String, String>) {
        self.app = app
        iconButton.setBackgroundImage(UIImage(named: app["name"]!), forState: UIControlState.Normal)
        nameLabel.text = app["name"]
        typeLabel.text = app["type"]
        priceLabel.text = app["price"] == "0.00" ? "Free" : "¥"+app["price"]!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
