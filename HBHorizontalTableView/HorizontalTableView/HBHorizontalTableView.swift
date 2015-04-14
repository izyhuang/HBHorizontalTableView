//
//  HBHorizontalTableView.swift
//  HBHorizontalTableView
//
//  Created by 黄招宇 on 15/3/27.
//  Copyright (c) 2015年 Huang Zhaoyu. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

@objc protocol HBTableViewDelegate: NSObjectProtocol {
    func tableView(horizontalTableView: HBHorizontalTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(horizontalTableView: HBHorizontalTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    optional func numberOfSectionsInTableView(horizontalTableView: HBHorizontalTableView) -> Int
    optional func tableView(horizontalTableView: HBHorizontalTableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func tableView(horizontalTableView: HBHorizontalTableView, viewForHeaderInSection section: Int) -> UIView?
    optional func tableView(horizontalTableView: HBHorizontalTableView, viewForFooterInSection section: Int) -> UIView?
    optional func tableView(horizontalTableView: HBHorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat
}

class HBHorizontalTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    var delegate: HBTableViewDelegate?
    var tableView: UITableView?
    
    var rowWidth: CGFloat {
        get {
            return tableView!.rowHeight
        }
    }
    
    var contentSize: CGSize {
        get {
            let size: CGSize = tableView!.contentSize
            return CGSizeMake(size.height, size.width)
        }
    }
    
    var contentOffset: CGPoint {
        get {
            let offset: CGPoint = tableView!.contentOffset
            return CGPointMake(offset.y, offset.x)
        }
    }
    
    var animated: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        println("horizontal TableView -> initWithFrame")
        setTableView()
        set_Frame(self.frame)
        setContentOffset(self.contentOffset)
        setRowWidth(self.rowWidth)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("horizontal TableView -> awakeFromNib")
        setTableView()
        set_Frame(self.frame)
        setContentOffset(self.contentOffset)
        setRowWidth(self.rowWidth)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTableView() {
        refreshOrientation()
        
        let tableView = UITableView(frame: self.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.showsVerticalScrollIndicator = false
        self.addSubview(tableView)
        self.tableView = tableView
        
        tableView.registerClass(HBAppCell.self, forCellReuseIdentifier: "app_cell")
        var cellNib: UINib = UINib(nibName: "HBAppCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "app_cell")
    }
    
    func set_Frame(frame: CGRect) {
        super.frame = frame
        refreshOrientation()
    }
    
    func setContentOffset(offset: CGPoint) {
        setContentOffset(offset, animated: false)
    }
    
    func setContentOffset(offset: CGPoint, animated: Bool) {
        tableView!.setContentOffset(CGPointMake(offset.x, offset.y), animated: animated)
    }
    
    func setRowWidth(rowWidth: CGFloat) {
        tableView!.rowHeight = rowWidth
    }
    
    func refreshOrientation() {
        if tableView == nil { return }
        
        // First reset rotation
        tableView!.transform = CGAffineTransformIdentity
        tableView!.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
        
        // Adjust frame
        let xOrigin = (self.bounds.size.width - self.bounds.size.height) / 2.0
        let yOrigin = (self.bounds.size.height - self.bounds.size.width) / 2.0
        tableView!.frame = CGRectMake(xOrigin, yOrigin, self.bounds.size.height, self.bounds.size.width)
        
        // Apply rotation again
        tableView!.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI)/2)
        tableView!.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.height - 7.0)
    }
    
    
    // MARK: TableView Delegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if delegate!.respondsToSelector("tableView:viewForHeaderInSection:") {
            let headerView: UIView = delegate!.tableView!(self, viewForHeaderInSection: section)!
            return headerView.frame.size.width
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if delegate!.respondsToSelector("tableView:viewForFooterInSection:") {
            let footerView: UIView = delegate!.tableView!(self, viewForFooterInSection: section)!
            return footerView.frame.size.width
        }
        return 0
    }
    
    func viewToHoldSectionView(sectionView: UIView) -> UIView {
        sectionView.frame = CGRectMake(0, 0, sectionView.frame.size.width, self.frame.size.height)
        let rotatedView = UIView(frame: sectionView.frame)
        rotatedView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
        sectionView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
        rotatedView.addSubview(sectionView)
        return rotatedView
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if delegate!.respondsToSelector("tableView:viewForHeaderInSection:") {
            let sectionView: UIView = delegate!.tableView!(self, viewForHeaderInSection: section)!
            return viewToHoldSectionView(sectionView)
        }
        return nil
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if delegate!.respondsToSelector("tableView:viewForFooterInSection:") {
            let sectionView: UIView = delegate!.tableView!(self, viewForFooterInSection: section)!
            return viewToHoldSectionView(sectionView)
        }
        return nil
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if delegate!.respondsToSelector("tableView:didSelectRowAtIndexPath:") {
            delegate!.tableView!(self, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if delegate!.respondsToSelector("tableView:widthForCellAtIndexPath:") {
            return delegate!.tableView!(self, widthForCellAtIndexPath: indexPath)
        }
        return tableView.rowHeight
    }
    
    
    // MARK: TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if delegate!.respondsToSelector("numberOfSectionsInTableView:") {
            return delegate!.numberOfSectionsInTableView!(self)
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.tableView(self, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = delegate!.tableView(self, cellForRowAtIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        // Rotate if needed
        if CGAffineTransformEqualToTransform(cell.contentView.transform, CGAffineTransformIdentity) {
            let xOrigin = (cell.bounds.size.width - cell.bounds.size.height) / 2.0
            let yOrigin	= (cell.bounds.size.height - cell.bounds.size.width) / 2.0
            cell.contentView.frame = CGRectMake(xOrigin, yOrigin, cell.bounds.size.height, cell.bounds.size.width)
            cell.contentView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.0))
        }
        return cell
    }

}