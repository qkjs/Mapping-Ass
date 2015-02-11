//
//  SecondViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/2/4.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController
{
    
    var year = [String]()
    var month = [String]()
    
    @IBOutlet weak var PV: UIPickerView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.PV.delegate = self
        self.PV.dataSource = self
        dateInPickData()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return year.count
        }
        else
        {
            return month.count
        }
    }
    
    func dateInPickData()
    {
        for i in 1...179
        {
            year.append(String(i))
        }
        for m in 1...59
        {
            month.append(String(m))
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if component == 0
        {
            return year[row]
        }
        else
        {
            return month[row]
        }
    }
    
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

/*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
    }
*/
}