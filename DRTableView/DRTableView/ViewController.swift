//
//  ViewController.swift
//  DRTableView
//
//  Created by DamonLi on 16/10/11.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    var tableVc:DRTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVc = DRTableViewController(style: .plain)
        tableVc.view.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64)
        tableVc.tableView.dataSource = self
        self.view.addSubview(tableVc.view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseCell")
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        }
        cell!.textLabel!.text = "第\((indexPath as NSIndexPath).row)行"
        return cell!
    }
    
    
}
