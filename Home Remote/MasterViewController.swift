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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        textView.becomeFirstResponder()
    }
    
}
