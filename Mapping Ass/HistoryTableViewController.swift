//
//  HistoryTableViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/24.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController
{
    
    var historys : [HistoryModel] = historyOption
    var filterHis = [HistoryModel]()
    
    @IBAction func leftNavBtn(sender: AnyObject)
    {
        tableView.reloadData()
    }
    
    @IBAction func closeAboutSegon(segon: UIStoryboardSegue)
    {
        print("Close")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func viewDidLoad()
    {
        navigationItem.leftBarButtonItem = editButtonItem()
        super.viewDidLoad()
        self.hideSearchBar()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        historys = historyOption
        if historys.count == 0
        {
            
        }
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.searchDisplayController!.searchResultsTableView
        {
            return self.filterHis.count
        }
        else
        {
            return self.historys.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as UITableViewCell
        
        var history : HistoryModel
        if tableView == self.searchDisplayController!.searchResultsTableView
        {
            history = filterHis[indexPath.row] as HistoryModel
        }
        else
        {
            history = historys[indexPath.row] as HistoryModel
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        
        cell.detailTextLabel?.text = formatter.stringFromDate(history.date)
        cell.textLabel?.text = history.type

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            println("\(historys)\(indexPath.row)")
        
            historys.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }

    }
    
    override func setEditing(editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let tempOptin = historys.removeAtIndex(sourceIndexPath.row)
        historys.insert(tempOptin,atIndex: destinationIndexPath.row)
    }
    
    func hideSearchBar()
    {
        var contentOffSet = tableView.contentOffset
        var h = self.searchDisplayController?.searchBar.frame.size.height
        h =  CGFloat(h!) + contentOffSet.y
        self.tableView.contentOffset.y = h!
        println("contentOffSet:\(contentOffSet)")
        println("h:\(h)")
        println("NewContent:\(self.tableView.contentOffset.y)")
    }
}

extension HistoryTableViewController: UISearchDisplayDelegate, UISearchBarDelegate
{
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool
    {
        filterHis = historys.filter(){$0.type.rangeOfString(searchString) != nil}
        return true
    }    
}
