//
//  MainViewController.swift
//  MakingChange
//
//  Created by Jim Halter on 5/25/15.
//  Copyright (c) 2015 HalterDev. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ENSideMenuDelegate {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDonate: UIButton!
    
    @IBOutlet var lblSavedAmount: UILabel!
    
    @IBOutlet weak var tblTransactions: UITableView!
    
    var transactions: [Double]!
    var transactionNames: [String]!
    
    var totalChange: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColorFromRGB("3498db", alpha: 1.0)
        
        topView.backgroundColor = UIColorFromRGB("3498db", alpha: 1.0)
        topView.frame.origin.x = 0
        topView.frame.origin.y = 0
        
        btnMenu.setTitleColor(UIColorFromRGB("ecf0f1", alpha: 1.0), forState: UIControlState.Normal)
        
        lblSavedAmount.textColor = UIColor.whiteColor()
        
        btnDonate.backgroundColor = UIColorFromRGB("2ecc71", alpha: 1.0)
        
        loadTransactions()
        
        self.tblTransactions.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if(false)
        {
            Users.AddUser()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(transactions == nil)
        {
            return 0
        }
        else
        {
            return self.transactions!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell = self.tblTransactions.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        var amt = "\(self.transactions![indexPath.row])"
        
        var str = split(amt) {$0 == "."}
        
        var change = str[1].toInt()
        change = (100 - change!)
        
        let font = UIFont(name: "Arial", size: 14.0) ?? UIFont.systemFontOfSize(10.0)
        let regFont = [NSFontAttributeName:font]
        
        let fontItal = UIFont(name: "Georgia-Italic", size: 10.0) ?? UIFont.systemFontOfSize(10.0)
        let italFont = [NSFontAttributeName:fontItal]
        
        let string = NSMutableAttributedString()
        
        var topString = NSAttributedString(string: "$0.\(change!)" + "\n", attributes: regFont)
        
        if(change == 100)
        {
            topString = NSAttributedString(string: "$1.00" + "\n", attributes: regFont)
        }
        
        let bottomString = NSAttributedString(string: "$\(amt)" + " - \(self.transactionNames![indexPath.row])", attributes:italFont)
        
        string.appendAttributedString(topString)
        string.appendAttributedString(bottomString)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.attributedText = string
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    private func loadTransactions()
    {
        var endpoint = NSURL(string: "https://tartan.plaid.com/connect")
        
//        Alamofire.request(.GET, "https://tartan.plaid.com/institutions").responseJSON()
//            {
//                (_, _, JSON, _) in
//                var credentials = JSON?[0].valueForKey("credentials") as! NSDictionary
//                //println(JSON)
//        }
//        
        Alamofire.request(.POST, endpoint!, parameters: ["client_id" : "test_id", "secret" : "test_secret", "username" : "plaid_test", "password" : "plaid_good", "type" : "wells"]).responseJSON()
        {
                (_,_,JSON,_) in
            
                var transDictionaries = JSON?.valueForKey("transactions") as! [NSDictionary]
            
                for transactionDictionary in transDictionaries
                {
                    if(self.transactions == nil)
                    {
                        self.transactions = [Double]()
                        self.transactionNames = [String]()
                    }
                    
                    self.transactions!.append(transactionDictionary.valueForKey("amount") as! Double)
                    self.transactionNames!.append(transactionDictionary.valueForKey("name") as! String)
                    
                    if(!Transactions.DoesTransactionExist(transactionId: transactionDictionary.valueForKey("_id") as! String))
                    {
                        Transactions.AddTransaction(transactionId: transactionDictionary.valueForKey("_id") as! String, amount: transactionDictionary.valueForKey("amount") as! Double, name: transactionDictionary.valueForKey(("name")) as! String)
                    }
                }
                self.tblTransactions.reloadData()
                self.calculateTotalPot()
        }
    }
    
    private func calculateTotalPot()
    {
        for(var i = 0; i < transactions.count; i++)
        {
            var amt = "\(self.transactions![i])"
            
            var str = split(amt) {$0 == "."}
            
            var change = str[1].toInt()
            change = (100 - change!)
            
            totalChange += change!
        }
        
        var dollars = totalChange / 100
        var remainder = totalChange % 100
        
        lblSavedAmount.text = "$\(dollars).\(remainder)"
    }
    
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject)
    {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen()
    {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose()
    {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool
    {
        println("sideMenuShouldOpenSideMenu")
        return true
    }
}

