//
//  ExpenseList.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/07.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit
import Foundation

struct RecordStruct {
    var num: Int
    var amount: Int
    var month: Int
    var day: Int
    var memo: String
}

class ExpenseList: NSObject {
    let expenses: [Int] = [1,2,4,5,8,103,102,121,199,3,6,7,9,105,111,112,113,114]

    let descriptionExpence:[String] = ["shokuhi: 1","nichiyouhin: 2","sake: 3","kousai: 4",
                                       "iryou: 5\n","jikotoushi: 6","kumiko: 7","kodomo: 8",
                                       "Suica,Pasmo: 9","kumiko","Shokuhi:103","KouTsuuhi:102",
                                       "JikoToushi:105","YogumataJi:121","kokuho:111",
                                       "NHK JyusinRyo:112","Jyumin-Sei:113","softbank:114",
                                       "other:199"]
    var records:[RecordStruct]
    
    static let sharedInstance: ExpenseList = ExpenseList()
    private override init() {
        records = []
    }
    
}
