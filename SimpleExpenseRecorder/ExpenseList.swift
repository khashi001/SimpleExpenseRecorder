//
//  ExpenseList.swift
//  SimpleExpenseRecorder
//
//  Created by 橋本久美子 on 2018/08/07.
//  Copyright © 2018年 Orange Forest. All rights reserved.
//

import UIKit
import Foundation

class ExpenseList: NSObject {
    let familyExpense: [Int] = [1,2,3,4,5,6,7,8,9]
    let personalExpense: [Int] = [103,102,105,121,111,112,113,114,199]
    let expenses: [Int] = [1,2,3,4,5,6,7,8,9,103,102,105,121,111,112,113,114,199]
//    let expenses: [Int] = [1,2,3]

    static let sharedInstance: ExpenseList = ExpenseList()
    private override init() {}
    
}
