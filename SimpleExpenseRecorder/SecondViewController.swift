//
//  SecondViewController.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/06.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    let offsetTextFieldNum:CGFloat = 240
    var textFieldNumInt:Int = 0
    
    @IBAction func buttonDelete(_ sender: Any){
        if textFieldNumInt > 0 {
            expenseList.removeRecord(_num: textFieldNumInt)
        }
        self.displayExpendRecords()
    }

    @IBOutlet weak var textFieldNum: UITextField!
    
    
     let expenseList: ExpenseManager = ExpenseManager.sharedInstance
    
    
    
    @IBOutlet weak var textViewRecords: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayExpendRecords()
        self.textFieldNum.delegate = self
        
        //Return Button for Num key input
        let returnKeyView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
        returnKeyView.backgroundColor = UIColor.darkGray
        
        let returnKeyButton = UIButton(frame:CGRect(x:105, y:5, width:170, height:70) )
        returnKeyButton .backgroundColor = UIColor.lightGray
        returnKeyButton.setTitle("Done", for: UIControlState.normal)
        returnKeyButton.titleLabel?.font = UIFont(name:"MomsDiner",size:23)
        
        returnKeyButton.addTarget(self, action: #selector(hitKeyboardReturnKey), for: UIControlEvents.touchUpInside)
        
        returnKeyView.addSubview(returnKeyButton)
        
        self.textFieldNum.inputAccessoryView = returnKeyView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayExpendRecords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayExpendRecords(){
        
        var displayStrings:String = ""
        for (index,word) in expenseList.records.enumerated(){
            displayStrings.append("[")
            displayStrings.append(String(index))
            displayStrings.append("] ")
            displayStrings.append(String(word.num))
            displayStrings.append(" ")
            displayStrings.append(String(word.amount))
            displayStrings.append(" ")
            displayStrings.append(String(word.month))
            displayStrings.append("/")
            displayStrings.append(String(word.day))
            displayStrings.append(" ")
            displayStrings.append(word.memo)
            displayStrings.append(" ")
            displayStrings.append("\n")
        }

        self.textViewRecords.text = displayStrings
    }
    
    
    @objc func hitKeyboardReturnKey(){
        
        let spaceDeletedString:String = (self.textFieldNum.text?.replacingOccurrences(of: " ", with: ""))!
        textFieldNumInt = ( spaceDeletedString == "" ) ? 0 : Int(spaceDeletedString)!
        
        self.textFieldNum.endEditing(true)
        self.textFieldNum.frame.origin.y += offsetTextFieldNum
        self.textFieldNum.resignFirstResponder()

        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textFieldNum.frame.origin.y -= offsetTextFieldNum
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldNum.frame.origin.y += offsetTextFieldNum
        textFieldNum.resignFirstResponder()
        return true
    }
    
    
}

