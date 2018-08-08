//
//  FirstViewController.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/06.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate  {
    
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var textFiedMemo: UITextField!
    @IBOutlet weak var viewExpenseFamily: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var viewHelp: UIView!
    
    @IBOutlet weak var textViewHelp: UITextView!
    
    @IBAction func buttonCloserHelp(_ sender: Any) {
        
        self.viewHelp.isHidden = true
        
    }
    
    @IBAction func buttonHelp(_ sender: Any) {
        self.viewHelp.isHidden = false
        
        var displayStrings:String = ""
        for word in expenseManager.catDescription{
            displayStrings.append(word)
            displayStrings.append("\n")
        }
        self.textViewHelp.text = displayStrings
        
        
    }
    var expenseNo: Int = 0
    var amountYen: String = ""
    var memoString: String = ""
    
    let expenseManager: ExpenseManager = ExpenseManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseManager.loadRecords()

        self.viewHelp.isHidden = true
        textFiedMemo.delegate = self as UITextFieldDelegate
        
        expenseNo = 0
        amountYen = ""
        
        //Return Button for Num key input
        let returnKeyView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        returnKeyView.backgroundColor = UIColor.darkGray
        
        let returnKeyButton = UIButton(frame:CGRect(x:105, y:5, width:170, height:40) )
        returnKeyButton .backgroundColor = UIColor.lightGray
        returnKeyButton.setTitle("Done", for: UIControlState.normal)
        returnKeyButton.titleLabel?.font = UIFont(name:"MomsDiner",size:23)
        
        returnKeyButton.addTarget(self, action: #selector(hitKeyboardReturnKey), for: UIControlEvents.touchUpInside)
        
        returnKeyView.addSubview(returnKeyButton)
        
        self.textFieldAmount.inputAccessoryView = returnKeyView

    }
    
    @objc func hitKeyboardReturnKey(){
        
        let spaceDeletedString:String = (self.textFieldAmount.text?.replacingOccurrences(of: " ", with: ""))!
        
//        let textInt:Int = ( spaceDeletedString == "" ) ? 0 : Int(spaceDeletedString)!
        
        self.amountYen = spaceDeletedString

        self.textFieldAmount.endEditing(true)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expenseManager.category.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = String(expenseManager.category[indexPath.row])

        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath){
        expenseNo = expenseManager.category[indexPath.row]

        let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        let label = selectedCell.contentView.viewWithTag(1) as! UILabel
        label.backgroundColor = UIColor(red: 236/255, green: 171/255, blue: 200/255, alpha: 1) //pale orange
    }

    func collectionView(_ collectionView: UICollectionView,didDeselectItemAt indexPath: IndexPath){
        let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        let label = selectedCell.contentView.viewWithTag(1) as! UILabel
        label.backgroundColor = UIColor(red: 178/255, green: 233/255, blue: 231/255, alpha: 1)//purple(default color)

    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.textFiedMemo.frame.origin.y -= 100
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFiedMemo.frame.origin.y += 100
        self.memoString = textFiedMemo.text!
        textFiedMemo.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonApply(_ sender: Any) {

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateformatter.string(from: datePicker.date)
        let strSeparated = strDate.components(separatedBy: "-")

        expenseManager.appendRecord(num: String(expenseNo),
                                    amount: amountYen,
                                    month: strSeparated[1],
                                    day: strSeparated[2],
                                    memo: memoString)
        
    }

    
    
}

