//
//  thirdViewController.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/30.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController, UITextFieldDelegate
{
    var editingTF : UITextField?
    var qianshiArr = [NSString]()
    var houshiArr = [NSString]()
    //数据绑定————------------------------
    @IBOutlet weak var qsTf: UITextField!
    @IBOutlet weak var hsTF: UITextField!
    @IBOutlet weak var hsCount: UITextField!
    @IBOutlet weak var qsCount: UITextField!
    @IBOutlet weak var qLcTf: UITextField!
    @IBOutlet weak var hbgTF: UITextField!
    @IBOutlet weak var hLcTf: UITextField!
    @IBOutlet weak var qBgTf: UITextField!
    @IBOutlet weak var resultTF: UILabel!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var tipTV: UITextView!
    @IBOutlet weak var leftNav: UIBarButtonItem!

    @IBOutlet weak var rightNav: UIBarButtonItem!
    //------------------------------------
    //action -----------------------------
    @IBAction func rightNavAct(sender: AnyObject)
    {
        self.okButtonStatus()
    }
    @IBAction func close(segon: UIStoryboardSegue)
    {
        //pass
    }
    @IBAction func leftNavAct(sender: AnyObject)
    {
        if self.editingTF == nil
        {
            self.clearData()
        }
        else
        {
            self.editingTF?.text = ""
        }
    }
    
    //----------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.qLcTf.delegate = self
        self.hLcTf.delegate = self
        self.qBgTf.delegate = self
        self.hbgTF.delegate = self
        self.rightNav.enabled = false
        self.initData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func submitResult()
    {
        var _qLc: NSString = self.qLcTf.text
        var _hLc: NSString = self.hLcTf.text
        var _qBg: NSString = self.qBgTf.text
        var _hBg: NSString = self.hbgTF.text
        var _qsh: NSString = self.qsTf.text
        var _hsh: NSString = self.hsTF.text
        
        let selectqLc = _qLc.doubleValue
        let selecthLc = _hLc.doubleValue
        let selectqBg = _qBg.doubleValue
        let selecthBg = _hBg.doubleValue
        let selectQsh = _qsh.doubleValue
        let selectHsh = _hsh.doubleValue
        

        var result = mainMath().bihechajisuan(selectqLc, hLc: selecthLc, qBg: selectqBg, hBg: selecthBg, qsh: selectQsh, hsh: selectHsh, standardT: 30.0)
        
        if result
        {
            self.resultTF.text = "合格"
            self.resultView.backgroundColor = UIColor.greenColor()
        }
        else
        {
            resultTF.text = "失格"
            resultView.backgroundColor = UIColor.redColor()
        }
        rightNav.enabled = false
    }
    
    func clearData()
    {
        qLcTf.text = ""
        hLcTf.text = ""
        qBgTf.text = ""
        hbgTF.text = ""
        qianshiArr = []
        houshiArr = []
        self.initData()
    }

    func saveHistory()
    {
        
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        self.editingTF?.resignFirstResponder()
        
    }
    
    func okButtonStatus()
    {
        if (self.editingTF == nil)
        {
            if qLcTf.text != "" && hLcTf.text != "" && qBgTf.text != "" && hbgTF.text != "" && qsTf.text != "" && hsTF.text != "" && qianshiArr.count == houshiArr.count
            {
                self.submitResult()
            }
        }
        else
        {
            self.editingTF?.resignFirstResponder()
            if qLcTf.text != "" && hLcTf.text != "" && qBgTf.text != "" && hbgTF.text != "" && qsTf.text != "" && hsTF.text != "" && qianshiArr.count == houshiArr.count
            {
                rightNav.enabled = true
            }
            else
            {
                if qianshiArr.count != houshiArr.count
                {
                 self.tipTV.text = "前数与后视数据个数不匹配，请查看"
                }
            }
        }
    }
    
    func initData()
    {
        var _qs:Double = 0.0
        var _hs:Double = 0.0
        for i in self.qianshiArr
        {
             var _qsTemp = i.doubleValue
            _qs += _qsTemp
        }

        
        for i in self.houshiArr
        {
            var _hsTemp = i.doubleValue
            _hs += _hsTemp
        }
        if qianshiArr.count == 0
        {
           qsTf.text = ""
           qsCount.text = "×0"
        }
        else
        {
            qsTf.text = NSString(format:"%.03f", _qs)
            qsCount.text = "×" + NSString(format:"%u", qianshiArr.count)
        }
        
        if houshiArr.count == 0
        {
            hsTF.text = ""
            hsCount.text = "×0"
        }
        else
        {
            hsTF.text = NSString(format:"%.03f", _hs)
            hsCount.text = "×" + NSString(format:"%u", houshiArr.count)
        }
        
        self.resultTF.text = "结果将会在这里显示"
        self.resultView.backgroundColor = UIColor.lightGrayColor()
        self.rightNav.enabled = false
        self.tipTV.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var biaogao = segue.destinationViewController as biaogaoTableViewController
        self.editingTF?.resignFirstResponder()
        
        if segue.identifier == "qianshihe"
        {
                biaogao.title = "前视数据"
                biaogao.type = 1
                biaogao.temp = qianshiArr
        }
       else if segue.identifier == "houshihe"
        {
                biaogao.title = "后视数据"
                biaogao.type = 2
                biaogao.temp = houshiArr
        }
    }
    
    @IBAction func closeBiaoGao(segon: UIStoryboardSegue)
    {
        var target = segon.sourceViewController as biaogaoTableViewController
        if target.type == 1
        {
            self.qianshiArr = target.temp
        }
        else if target.type == 2
        {
            self.houshiArr = target.temp
        }
        self.initData()
        if qLcTf.text != "" && hLcTf.text != "" && qBgTf.text != "" && hbgTF.text != "" && qsTf.text != "" && hsTF.text != "" && qianshiArr.count == houshiArr.count
        {
            rightNav.enabled = true
        }
        else
        {
            if qianshiArr.count != houshiArr.count
            {
                self.tipTV.text = "前数与后视数据个数不匹配，请查看"
            }
        }
        self.resetStatusBar()
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.rightNav.enabled = true
        self.rightNav.title = "完成"
        self.leftNav.title = "更正"
        self.editingTF = textField
        self.resetStatusBar()
        self.tipTV.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        self.rightNav.enabled = false
        self.rightNav.title = "计算"
        self.leftNav.title = "清除"
        self.editingTF = nil
    }
    
    func resetStatusBar()
    {
        self.resultTF.text = "结果将会在这里显示"
        self.resultView.backgroundColor = UIColor.lightGrayColor()
    }
}
