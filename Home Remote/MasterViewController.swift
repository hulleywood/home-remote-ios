//
//  MasterViewController.swift
//  Home Remote
//
//  Created by James Hulley on 6/21/15.
//  Copyright (c) 2015 James Hulley. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var keyboardSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        textView.becomeFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.keyboardSpace.constant = keyboardFrame.size.height
        })
        
        //println("\(UIApplication.sharedApplication().statusBarOrientation)")
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.keyboardSpace.constant = 0
        })
        //println("\(UIApplication.sharedApplication().statusBarOrientation)")
    }
}
