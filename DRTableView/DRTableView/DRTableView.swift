//
//  DRTableView.swift
//  DRTableView
//
//  Created by DamonLi on 16/10/11.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit

class DRTableView: UITableView,RefreshViewDelegate,UIScrollViewDelegate{

    fileprivate var refreshView:RefreshView!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        refreshView = RefreshView(frame: CGRect(x: 0, y: -DRefreshViewHeight, width: bounds.width, height: DRefreshViewHeight), scrollView: self)
        refreshView.delegate = self
        //将刷新视图放到tableview的后面
        self.insertSubview(refreshView, at: 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //RefreshViewDelegate Mark
    func refreshViewStartLoading(refreshView: RefreshView) {
        DispatchQueue.global().async {
            sleep(3)
            DispatchQueue.main.async(execute: {
                refreshView.endLoading()
            })
        }
    }
    
    //监听用户滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
