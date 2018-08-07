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
    @IBOutlet weak var viewExpenseFamily: UIView!
    
    @IBOutlet weak var labelDateConfirm: UILabel!
    
    @IBOutlet weak var labelExpenseConfirm: UILabel!
    
    @IBOutlet weak var textFiedMemo: UITextField!
    
    
    
//    @IBAction func textFieldMemoEditingDidEnd(_ sender: UITextField) {
//
//        textFiedMemo.resignFirstResponder()
//    }
//
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFiedMemo.resignFirstResponder()
        return true
    }
    
    
    var expenseNo:Int!
    var amountYen:Int!
    
    let expenseList :ExpenseList = ExpenseList.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFiedMemo.delegate = self as UITextFieldDelegate
        
        expenseNo = 0
        amountYen = 0
        
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
        
        let textInt:Int = ( self.textFieldAmount.text == "" ) ? 0 : Int(self.textFieldAmount.text!)! //入力欄に入っている数値。未入力だったときは0とする
        
        self.amountYen = textInt
        self.labelExpenseConfirm.text = String(textInt)

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
        return expenseList.expenses.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = String(expenseList.expenses[indexPath.row])
        

        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath){
        expenseNo = expenseList.expenses[indexPath.row]
        print(expenseNo)

    }
    
    
}

