//
//  DRTableViewController.swift
//  DRTableView
//
//  Created by DamonLi on 16/9/8.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit

let DRefreshViewHeight:CGFloat = 200

class DRTableViewController: UITableViewController,RefreshViewDelegate {
    fileprivate var refreshView:RefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshView = RefreshView(frame: CGRect(x: 0, y: -DRefreshViewHeight, width: view.bounds.width, height: DRefreshViewHeight), scrollView: self.tableView)
        refreshView.delegate = self
        //将刷新视图放到tableview的后面
        self.view.insertSubview(refreshView, at: 0)
    }
    
    //监听用户滑动
    override func scrollViewDidScroll( _ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView);
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        cell.textLabel!.text = "第\((indexPath as NSIndexPath).row)行"
        return cell
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

}
