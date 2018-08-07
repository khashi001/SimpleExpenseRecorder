//
//  SecondViewController.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/06.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

     let expenseList: ExpenseList = ExpenseList.sharedInstance
    
    
    
    @IBOutlet weak var textViewRecords: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var displayStrings:String = ""
        
        for word in expenseList.records{
            displayStrings.append(String(word.num))
            displayStrings.append(" ")
            displayStrings.append(String(word.amount))
            displayStrings.append(" ")
            displayStrings.append(String(word.month))
            displayStrings.append(" ")
            displayStrings.append(String(word.day))
            displayStrings.append(" ")
            displayStrings.append(word.memo)
            displayStrings.append(" ")
            displayStrings.append("\n")
        }
        self.textViewRecords.text = displayStrings
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

