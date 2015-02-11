//
//  FirstViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/24.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    var degree :[Int] = []
    var mins : [Int] = []
    var history : HistoryModel?
    
    @IBOutlet weak var yzTextFeild: UITextField!
    @IBOutlet weak var qzTextFeild: UITextField!
    @IBOutlet weak var groupSelect: UISegmentedControl!
    @IBOutlet weak var navRightBut: UIBarButtonItem!
    @IBOutlet weak var rTextFiekd: UITextField!
    @IBOutlet weak var degressPicker: UIPickerView!
    @IBOutlet weak var tTextFeild: UITextField!
    @IBOutlet weak var lTextFeild: UITextField!
    @IBOutlet weak var eTextFeild: UITextField!
    @IBOutlet weak var sTF: UITextField!
    @IBOutlet weak var sTestF: UILabel!
    @IBOutlet weak var r0Lab: UILabel!
    @IBOutlet weak var r0TextFaile: UITextField!
    
    @IBOutlet weak var hyTF: UITextField!
    @IBOutlet weak var hyLa: UILabel!
    @IBOutlet weak var yhTextLabel: UITextField!
    @IBOutlet weak var yhLa: UILabel!
    @IBOutlet weak var yzLa: UILabel!
    @IBAction func grounpAct(sender: AnyObject)
    {
        self.groupSelectCheck()
    }
    
    @IBAction func leftNavButAct(sender: AnyObject)
    {
        self.initView(0)
    }
    
    @IBAction func rightNavButAct(sender: AnyObject)
    {
        if rTextFiekd.editing == true || r0TextFaile.editing == true || sTF.editing == true
        {
            rTextFiekd.resignFirstResponder()
            r0TextFaile.resignFirstResponder()
            sTF.resignFirstResponder()  
            self.okButtonStatus()
        }
        else
        {
            self.resultSunmit()
        }
    }
    
    //interface
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initView(0)
        self.groupSelectCheck()
      
        for i in 0...179
        {
            degree.append(i)
        }
        
        for m in  0...59
        {
            mins.append(m)
        }
 
        degressPicker.dataSource = self
        degressPicker.delegate = self
        rTextFiekd.delegate = self
        r0TextFaile.delegate = self
        sTF.delegate = self
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        rTextFiekd.resignFirstResponder()
        sTF.resignFirstResponder()
        r0TextFaile.resignFirstResponder()
        
        self.okButtonStatus()
    }
    
    // user func
    func initView(t:Int?)
    {
        if t != 1
        {
            navRightBut.enabled = false
            sTF.text = "0"
            //r0TextFaile.text = "0"
            rTextFiekd.placeholder = "请输入半径"
            rTextFiekd.text = ""
            degressPicker.selectRow(0, inComponent: 0, animated: true)
            degressPicker.selectRow(0, inComponent: 1, animated: true)
            degressPicker.selectRow(0, inComponent: 2, animated: true)
        }
        tTextFeild.text = ""
        lTextFeild.text = ""
        eTextFeild.text = ""
        qzTextFeild.text = ""
        yzTextFeild.text = ""
        r0TextFaile.text = ""
        hyTF.text = ""
        yhTextLabel.text = ""
    }
    func resultSunmit()
    {
        var _degree = degressPicker.selectedRowInComponent(0)
        var _min = degressPicker.selectedRowInComponent(1)
        var _second = degressPicker.selectedRowInComponent(2)
        var _r: NSString = rTextFiekd.text
        var _zy: NSString = sTF.text
        var _l0: NSString = r0TextFaile.text
        
        var selectR = _r.doubleValue
        var selectZy = _zy.doubleValue
        var selectl0 = _l0.doubleValue
        
        var selectDegress = Double(_degree) + mainMath().fromMins(Double(_min)) + mainMath().fromSecond(Double(_second))
        let result = mainMath()
        
        if self.groupSelect.selectedSegmentIndex == 0
        {
            let selectT = result.qianxianchang(selectDegress,r: selectR)
            let selectE = result.waishiju(selectDegress, r: selectR)
            let selectL = result.quxianchang(selectR, r: selectR)
            
            let selectQz = selectL / 2.0
            let selectYz = selectZy + selectL
            
            eTextFeild.text = NSString(format:"%.03f", selectE)
            tTextFeild.text = NSString(format:"%.03f", selectT)
            lTextFeild.text = NSString(format:"%.03f", selectL)
            qzTextFeild.text = NSString(format:"%.03f", selectQz)
            yzTextFeild.text = NSString(format:"%.03f", selectYz)
        }
        else //有缓和曲线
        {
            let selectT = result.qixianchang_y(selectDegress, r:selectR, l0: selectl0)
            let selectE = result.waishiju_y(selectDegress, r: selectR, l0: selectl0)
            let selectL = result.quxianchang_y(selectDegress, r: selectR, l0: selectl0)
            
            let selectHY = selectZy + selectl0
            let selectQZ = selectZy + (selectL/2)
            let selectYH = selectZy + selectL - selectl0
            let selectHZ = selectZy + selectL
            
            eTextFeild.text = NSString(format:"%.03f", selectE)
            tTextFeild.text = NSString(format:"%.03f", selectT)
            lTextFeild.text = NSString(format:"%.03f", selectL)
            hyTF.text = NSString(format:"%.03f", selectHY)
            qzTextFeild.text = NSString(format:"%.03f", selectQZ)
            yhTextLabel.text = NSString(format:"%.03f", selectYH)
            yzTextFeild.text = NSString(format:"%.03f", selectHZ)
            
        }
        self.saveHistory(NSString(format:"%.f", selectDegress))
        navRightBut.enabled = false
    }
    func saveHistory(degress:NSString)
    {
        let r = rTextFiekd.text
        let d = degress
        let zh = sTF.text
        let r0 = r0TextFaile.text
        
        let t = tTextFeild.text
        let l = lTextFeild.text
        let e = eTextFeild.text
        let qz = qzTextFeild.text
        let yz = yzTextFeild.text
        
        let uuid = NSUUID().UUIDString
        
        if self.groupSelect.selectedSegmentIndex == 0
        {
            history = HistoryModel(id:uuid, type: "无缓和曲线", cuData: NSDate(), cuIntputArr: NSArray(), cuOutputArr: NSArray())
        }
        else
        {
            history = HistoryModel(id:uuid, type: "有缓和曲线", cuData: NSDate(), cuIntputArr: NSArray(), cuOutputArr: NSArray())
        }
        historyOption.append(history!)
    }
    
    func okButtonStatus()
    {
        if self.groupSelect.selectedSegmentIndex == 0
        {
            if rTextFiekd.text != "" && self.sTF.text != ""
            {
                navRightBut.enabled = true
            }
            else
            {
                navRightBut.enabled = false
            }
        }
        else
        {
            if rTextFiekd.text != "" && sTF.text != "" && r0TextFaile.text != ""
            {
                navRightBut.enabled = true
            }
            else
            {
                navRightBut.enabled = false
            }
        }
    }

    func groupSelectCheck()
    {
        if self.groupSelect.selectedSegmentIndex == 0
        {
            self.r0Lab.hidden = true
            self.r0TextFaile.hidden = true
            
            self.sTestF.text = "ZY:"
           
            self.hyLa.hidden = true
            self.hyTF.hidden = true
            
            self.yhTextLabel.hidden = true
            self.yhLa.hidden = true
            
            self.yzLa.text = "YZ:"
        }
        else
        {
            self.r0Lab.hidden = false
            self.r0TextFaile.hidden = false
            
            self.sTestF.text = "ZH:"
            
            self.hyLa.hidden = false
            self.hyTF.hidden = false
            
            self.yhLa.hidden = false
            self.yhTextLabel.hidden = false
            
            self.yzLa.text = "HZ:"
        }
        self.initView(1)
        self.okButtonStatus()
    }
}

extension  FirstViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(textField: UITextField)
    {
        navRightBut.enabled = true
        navigationItem.rightBarButtonItem?.title = "完成"
        navigationItem.leftBarButtonItem?.title = ""
    }
    func textFieldDidEndEditing(textField: UITextField)
    {
        navigationItem.rightBarButtonItem?.title = "计算"
        navigationItem.leftBarButtonItem?.title = "清空"
    }
}

extension FirstViewController: UIPickerViewDataSource
{
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return degree.count
        }
        else
        {
            return mins.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if component == 0
        {
            return String(degree[row])
        }
        else if component == 1
        {
            return String(mins[row])
        }
        else
        {
            return String(mins[row])
        }
    }
}

extension FirstViewController: UIPickerViewDelegate
{
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.okButtonStatus()
    }
}

