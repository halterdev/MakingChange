//
//  Users.swift
//  MakingChange
//
//  Created by Jim Halter on 6/1/15.
//  Copyright (c) 2015 HalterDev. All rights reserved.
//

import Foundation
import Parse

class Users
{
    /**
    Add a new User to the db
    **/
    static func AddUser()
    {
        var user = PFUser()
        
        user.email = "test@test.com"
        user.username = "Test"
        user.password = "test"
        user.setValue(0, forKey: "donationpot")
        
        user.signUp()
    }
    
    /**
    Add to a User's donation pot
    
    :param: user PFUser
    :param: amount Double
    **/
    static func AddToUsersDonationPot(#user: PFUser, amount: Double)
    {
        var query = PFQuery(className: PFUser.parseClassName())
        query.whereKey("objectId", equalTo: user.objectId!)
        
        var user = query.getFirstObject() as! PFUser
        
        var newAmt = (user.valueForKey("donationpot") as! Double) + amount
        
        user.setValue(newAmt, forKey: "donationpot")
        user.saveInBackground()
    }
}