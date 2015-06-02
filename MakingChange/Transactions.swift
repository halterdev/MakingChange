//
//  Transactions.swift
//  MakingChange
//
//  Created by Jim Halter on 6/1/15.
//  Copyright (c) 2015 HalterDev. All rights reserved.
//

import Foundation
import Parse

class Transactions
{
    /**
    Check to see if a Transaction has already been saved to the db
    
    :param: transactionId String
    :return: True if transactionId exists
    **/
    static func DoesTransactionExist(#transactionId: String) -> Bool
    {
        var result = false
        
        var query : PFQuery = PFQuery(className: "transactions")
        query.whereKey("transactionid", equalTo: transactionId)
        
        result = (query.countObjects() > 0)
        
        return result
    }
    
    /**
    Add Transaction to the db
    
    :param: transactionId String
    :param: amount Double
    **/
    static func AddTransaction(#transactionId: String, amount: Double, name: String)
    {
        var transactionObj: PFObject = PFObject(className: "transactions")
        
        transactionObj.setValue(transactionId, forKey: "transactionid")
        transactionObj.setValue(amount, forKey: "amount")
        transactionObj.setValue(name, forKey: "name")
        
        transactionObj.saveInBackground()
    }
}