//
//  FirstViewController.swift
//  Home Remote
//
//  Created by James Hulley on 5/26/15.
//  Copyright (c) 2015 James Hulley. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let baseUrl = "http://10.0.1.54:3000"

    @IBAction func powerPressed(sender: AnyObject) {
        sendRemoteSignal("projector", code: "KEY_POWER")
        sendRemoteSignal("projector", code: "KEY_POWER")
    }
    
    @IBAction func sourceOnePressed(sender: AnyObject) {
        sendRemoteSignal("projector", code: "KEY_1")
    }
    
    @IBAction func sourceTwoPressed(sender: AnyObject) {
        sendRemoteSignal("projector", code: "KEY_2")
    }

    @IBAction func volumeDownPressed(sender: AnyObject) {
        sendRemoteSignal("logitech_stereo", code: "KEY_VOLUMEDOWN")
    }
    
    @IBAction func volumeUpPressed(sender: AnyObject) {
        sendRemoteSignal("logitech_stereo", code: "KEY_VOLUMEUP")
    }
    
    @IBAction func mutePressed(sender: AnyObject) {
        sendRemoteSignal("logitech_stereo", code: "KEY_MUTE")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // check status here
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.s
    }
    
    func sendRemoteSignal(remote: String, code: String) {
        var url = NSURL(fileURLWithPath: "\(baseUrl)/send/\(remote)/\(code)")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            //do something
        })
    }

}

