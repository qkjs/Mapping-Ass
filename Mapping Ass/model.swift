//
//  model.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/25.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

var historyOption: [HistoryModel] = []

class HistoryModel: NSObject
{
    var id: String
    var type: String
    var date: NSDate
    var inputArr: NSArray
    var outputArr: NSArray
    
    init(id: String, type:String, cuData: NSDate, cuIntputArr: NSArray, cuOutputArr: NSArray)
    {
        self.id = id
        self.type = type
        self.date = cuData
        self.inputArr = cuIntputArr
        self.outputArr = cuOutputArr
    }
}
