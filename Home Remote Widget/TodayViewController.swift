//
//  TodayViewController.swift
//  Home Remote Widget
//
//  Created by James Hulley on 5/31/15.
//  Copyright (c) 2015 James Hulley. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    struct Config {
        let baseUrl: String
        var roomOnline: Bool
        var room: String
    }
    
    var config = Config(baseUrl: "http://10.0.1.54:2488", roomOnline: true, room: "living_room")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(320, 60);
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 40, 0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func powerButtonPressed(sender: AnyObject) {
        sendRemoteSignal("projector", code: "KEY_POWER")
        sendRemoteSignal("projector", code: "KEY_POWER")
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
    
    func sendRemoteSignal(remote: String, code: String) {
        var url = NSURL(string: "\(config.baseUrl)/send/\(remote)/\(code)")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            if error != nil {
                println("An error occured while sending \(code) to \(remote)")
                println(error)
            } else {
                println("Successfully sent \(code) to \(remote)")
            }
        })
        
        if config.roomOnline {
            dataTask.resume()
        } else {
            println("Cannot send \(code) to \(remote) because \(config.room) is offline")
        }
    }

    
}
