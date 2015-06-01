//
//  DonationsViewController.swift
//  MakingChange
//
//  Created by Jim Halter on 5/25/15.
//  Copyright (c) 2015 HalterDev. All rights reserved.
//

import UIKit

class DonationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ENSideMenuDelegate {

    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var tbl30Days: UITableView!
    
    var donationsThirty: [String] = ["$5.00 American Red Cross", "$5.00 Diabetes.org", "$5.00 Breast Cancer"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = UIColorFromRGB("3498db", alpha: 1.0)
        
        topView.backgroundColor = UIColorFromRGB("3498db", alpha: 1.0)
        
        btnMenu.setTitleColor(UIColorFromRGB("ecf0f1", alpha: 1.0), forState: UIControlState.Normal)
        
        lblAmount.textColor = UIColor.whiteColor()
        lblAmount.text = "$15.00"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell = self.tbl30Days.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.donationsThirty[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }

    @IBAction func segmentChanged(sender: AnyObject)
    {
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleMenu(sender: AnyObject)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
