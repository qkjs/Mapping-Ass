//
//  AddNewDataTableViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/30.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class AddNewDataTableViewController: UITableViewController,UITextFieldDelegate
{

    @IBOutlet weak var DataText: UITextField!
    
    @IBAction func clearAct(sender: AnyObject)
    {
        self.DataText.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.DataText.delegate = self
        self.DataText.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.DataText.resignFirstResponder()
    }
    
}
