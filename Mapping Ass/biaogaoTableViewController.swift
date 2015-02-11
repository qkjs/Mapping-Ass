//
//  biaogaoTableViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/30.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class biaogaoTableViewController: UITableViewController
{
    
    var type: Int?
    var temp = [NSString]()
    
    @IBOutlet weak var TipTF: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.foot()
        //self.tableView.tableFooterView = UIView()
    }
    
    func foot()
    {
        var tipText = UILabel()
        tipText.text = String(temp.count) + "个数据"
        let tipW = self.tableView.frame.size.width/2.0
        tipText.frame = CGRectMake(tipW - 40, 0, 80, 30.0)
        var footView = UIView(frame: CGRectMake(0,0, self.tableView.frame.size.width, 30))
        //footView.backgroundColor = UIColor.redColor()
        footView.addSubview(tipText)
        self.tableView.tableFooterView = footView
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.foot()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return temp.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("biaogaoCell", forIndexPath: indexPath) as UITableViewCell
        
        var result = temp[indexPath.row]
        cell.textLabel?.text = String(indexPath.row + 1) + ": "
        cell.detailTextLabel?.text = result
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "addNewData"
        {
            var addNew = segue.destinationViewController as AddNewDataTableViewController
            if self.type == 1
            {
                addNew.title = "添加数据-前视"
            }
            else if self.type == 2
            {
                addNew.title = "添加数据-后视"
            }
        }
    }
    
    @IBAction func closeAddNew(segon: UIStoryboardSegue)
    {
    
    var target = segon.sourceViewController as AddNewDataTableViewController
    if target.DataText.text != ""
    {
        self.temp.append(target.DataText.text)
    }
    self.tableView.reloadData()
    
    if overHigh() != 0
    {
        self.tableView.contentOffset.y = overHigh()

    }
  }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        self.temp.removeAtIndex(indexPath.row)
        self.foot()
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func overHigh() -> CGFloat
    {
        var count = temp.count
        var countHigh = count * 32 + 30
        var screenHigh = self.tableView.frame.size.height - 66
        println(screenHigh)
        println(countHigh)
        if  CGFloat(countHigh) > screenHigh
        {
            var _countHigh =  CGFloat(countHigh)
            var result = _countHigh - screenHigh
            return result
        }
        else
        {
            return 0
        }
        
    }
}
