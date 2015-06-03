//
//  LoginViewController.swift
//  MakingChange
//
//  Created by Jim Halter on 5/27/15.
//  Copyright (c) 2015 HalterDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet var loginRegisterSegment: UISegmentedControl!
    
    @IBOutlet var txtLoginEmail: UITextField!
    @IBOutlet var txtLoginPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var loginView: UIView!
    
    @IBOutlet var txtRegisterEmail: UITextField!
    @IBOutlet var txtRegisterPassword: UITextField!
    @IBOutlet var bankPicker: UIPickerView!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var registerView: UIView!
    
    var banks = ["Bank of America", "Citi", "Wells Fargo"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColorFromRGB("2c3e50", alpha: 1.0)
        
        loginRegisterSegment.tintColor = UIColorFromRGB("ecf0f1", alpha: 1.0)
        
        loginView.backgroundColor = UIColorFromRGB(("ecf0f1"), alpha: 1.0)
        loginView.layer.cornerRadius = 5.0
        
        registerView.backgroundColor = UIColorFromRGB("ecf0f1", alpha: 1.0)
        registerView.layer.cornerRadius = 5.0
        
        btnLogin.backgroundColor = UIColorFromRGB("2ecc71", alpha: 1.0)
        btnLogin.setTitleColor(UIColorFromRGB("ecf0f1", alpha: 1.0), forState: UIControlState.Normal)
        
        loginView.hidden = false
        registerView.hidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return banks.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return banks[row]
    }
    
    @IBAction func segmentChanged(sender: AnyObject)
    {
        if(loginRegisterSegment.selectedSegmentIndex == 0)
        {
            loginView.hidden = false
            registerView.hidden = true
        }
        else
        {
            loginView.hidden = true
            registerView.hidden = false
        }
    }
    
    @IBAction func btnLoginPressed(sender: AnyObject)
    {
        var VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("MyNavigationController") as! MyNavigationController
        
        self.presentViewController(VC1, animated:true, completion: nil)
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
}
