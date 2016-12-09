//
//  AccessTokenViewController.swift
//  Task Assist
//
//  Created by Makkena,Srinivasa Rao on 12/8/16.
//  Copyright © 2016 Makkena,Srinivasa Rao. All rights reserved.
//

import UIKit

class AccessTokenViewController: UIViewController,UIPopoverPresentationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var accessTokenTF: UITextField!
    
    var courseAndPercentages: CoursesAndPercentages!
    override func viewDidLoad() {
        super.viewDidLoad()
        courseAndPercentages = CoursesAndPercentages()
        print(accessTokenTF.text)
        if accessTokenTF.text != ""{
            //CoursesAndPercentages.course(accessTokenTF.text!)
            //CalendarEvents.courses(accessTokenTF.text!)
            
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var loginBTN: UIButton!
    @IBAction func loginBTN(sender: AnyObject) {
        if accessTokenTF.text != "" && accessTokenTF.text?.characters.count == 69{
        
        CoursesAndPercentages.course(accessTokenTF.text!)
            CalendarEvents.courses(accessTokenTF.text!)
            self.performSegueWithIdentifier("login", sender: self)
        }else{
            displayMessage("Please enter valid access token")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func textFieldShouldReturn(textField:UITextField) -> Bool{
        //if(textField == self.topTF) —
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func popOverToGetAccessToken(sender: UIButton) {
        self.performSegueWithIdentifier("tokenHelp", sender: self)
    
        
        
        
    }
        
    
    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "tokenHelp"{
            let tokenHelpVC = segue.destinationViewController as! AccessTokenHelpViewController
            
            let controller = tokenHelpVC.popoverPresentationController
            
            if controller != nil{
                controller?.delegate = self
                
            }
            
        }
        
        
        
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }

    
    // Pass in a String and it will be displayed in an alert view
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }

}
