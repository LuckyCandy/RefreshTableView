//
//  ViewController.swift
//  DRTableView
//
//  Created by DamonLi on 16/10/11.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDataSource,DRTableViewControllerDelegate {
    private var tableVc:DRTableViewController!
    private var songList:[SongDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVc = DRTableViewController(style: .plain)
        tableVc.view.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64)
        tableVc.tableView.dataSource = self
        tableVc.drDelegate = self
        self.view.addSubview(tableVc.view)

        startRefresh()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseCell")
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        }
        cell!.textLabel!.text = "\(songList[indexPath.row].name) --\(songList[indexPath.row].singer)"
        return cell!
    }
    
    func startRefresh(){
            Alamofire.request("http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=1&size=10&offset=0").validate(contentType: ["application/json"]).responseJSON{ response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let data = JSON(json)
                        for dt in data["song_list"].array!{
                            self.songList.append(SongDetail(withJson:dt))
                        }
                            self.tableVc.tableView.reloadData()       
                            self.tableVc.endRefresh()
                    }else{
                        print("\(response.result.value)")
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
