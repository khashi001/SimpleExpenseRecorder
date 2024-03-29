//
//  ExpenseManager.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/08.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//
//

import UIKit
import Foundation

struct UserDefaultsKey{
    static let Record = "record"
}
struct SerializedKey{
    static let Num = "num"
    static let Amount = "amount"
    static let Month = "month"
    static let Day = "day"
    static let Memo = "memo"
}

class ExpenseRecord: NSObject,NSCoding{
    var num: String
    var amount: String
    var month: String
    var day: String
    var memo: String
    
    init(_num: String, _amount: String, _month: String, _day: String, _memo: String){
        self.num = _num
        self.amount = _amount
        self.month = _month
        self.day = _day
        self.memo = _memo
    }
    
    required init?(coder aDecoder: NSCoder){
        self.num = aDecoder.decodeObject(forKey: SerializedKey.Num) as? String ?? ""
        self.amount = aDecoder.decodeObject(forKey: SerializedKey.Amount) as? String ?? ""
        self.month = aDecoder.decodeObject(forKey: SerializedKey.Month) as? String ?? ""
        self.day = aDecoder.decodeObject(forKey: SerializedKey.Day) as? String ?? ""
        self.memo = aDecoder.decodeObject(forKey: SerializedKey.Memo) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.num, forKey: SerializedKey.Num)
        aCoder.encode(self.amount, forKey: SerializedKey.Amount)
        aCoder.encode(self.month, forKey: SerializedKey.Month)
        aCoder.encode(self.day, forKey: SerializedKey.Day)
        aCoder.encode(self.memo, forKey: SerializedKey.Memo)
    }
}


class ExpenseManager: NSObject{
    let category: [Int] = [1,2,4,5,8,103,102,121,199,3,6,7,9,105,111,112,113,114]
    
    let catDescription:[String] = ["Shokuhi: 1","Nichiyouhin: 2","Sake: 3","Kousai: 4",
                                   "Iryou: 5\n","Jikotoushi: 6","Personal: 7","Kodomo: 8",
                                   "Suica,Pasmo: 9","Personal:","Shokuhi:103","KouTsuuhi:102",
                                   "JikoToushi:105","Karma Yoga:121","Kokuho:111",
                                   "NHK JyusinRyo:112","Jyumin-Sei:113","Softbank:114",
                                   "Other:199"]
    var records:[ExpenseRecord] = []
    
    static let sharedInstance: ExpenseManager = ExpenseManager()
    private let userDefaults = UserDefaults.standard
    
    func appendRecord(num: String, amount: String, month: String, day: String, memo: String ){
        self.records.append( ExpenseRecord(
            _num: num, _amount: amount, _month: month, _day: day, _memo: memo))
        saveRecords()
    }
    
    func removeRecord(_num: Int){
        if(self.records.count > _num){
            self.records.remove(at: _num)
            saveRecords()
        }
    }


    func saveRecords(){
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: records)
        userDefaults.set(archivedObject, forKey: UserDefaultsKey.Record)
        userDefaults.synchronize()
    }
    
    func loadRecords(){
        if let loadedRecords = userDefaults.data(forKey: UserDefaultsKey.Record) {
            self.records = NSKeyedUnarchiver.unarchiveObject(with: loadedRecords) as! [ExpenseRecord]
        }
        else{
            self.records = []
            //index 0 is Heading
            self.records.append( ExpenseRecord(_num: "No / ", _amount: "Amount / ", _month: "MM/", _day: "DD / ", _memo: "Memo"))
        }
    }
}
