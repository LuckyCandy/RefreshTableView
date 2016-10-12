//
//  DRTableViewController.swift
//  DRTableView
//
//  Created by DamonLi on 16/9/8.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit

let DRefreshViewHeight:CGFloat = 200

protocol DRTableViewControllerDelegate {
    func startRefresh()
}

class DRTableViewController: UITableViewController,RefreshViewDelegate {
    fileprivate var refreshView:RefreshView!
    
    var drDelegate:DRTableViewControllerDelegate?
    
    override init(style: UITableViewStyle) {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshView = RefreshView(frame: CGRect(x: 0, y: -DRefreshViewHeight, width: view.bounds.width, height: DRefreshViewHeight), scrollView: self.tableView)
        refreshView.delegate = self
        //将刷新视图放到tableview的后面
        self.view.insertSubview(refreshView, at: 0)
    }
    
    //监听用户滑动
    override func scrollViewDidScroll( _ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
    //RefreshViewDelegate Mark
    func refreshViewStartLoading(refreshView: RefreshView) {
        drDelegate?.startRefresh()
    }
    
    func endRefresh(){
        print("加载结束")
        refreshView.endLoading()
    }

}
