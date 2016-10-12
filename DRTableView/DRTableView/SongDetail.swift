//
//  SongDetail.swift
//  DRTableView
//
//  Created by DamonLi on 2016/10/12.
//  Copyright © 2016年 Pioneer. All rights reserved.
//

import Foundation
import SwiftyJSON

class SongDetail{
    var name:String = ""
    var singer:String = ""
    
    init(withJson:JSON) {
        name = withJson["title"].stringValue
        singer = withJson["artist_name"].stringValue
    }
}
