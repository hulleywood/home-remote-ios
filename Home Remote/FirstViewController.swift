//
//  FirstViewController.swift
//  Home Remote
//
//  Created by James Hulley on 5/26/15.
//  Copyright (c) 2015 James Hulley. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    struct Config {
        let baseUrl: String
        var livingRoomOnline: Bool
        var bedRoomOnline: Bool
    }

    //var config = Config(baseUrl: "http://10.0.1.54:3000", livingRoomOnline: false, bedRoomOnline: false)
    var config = Config(baseUrl: "http://127.0.0.1:3000", livingRoomOnline: false, bedRoomOnline: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // check status here
        setBedRoomStatus()
        setLivingRoomStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.s
    }
    
    func setLivingRoomStatus() {
        var url = NSURL(string: "\(config.baseUrl)/living_room/monitor")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            if error != nil {
                println("An error occured while loading the living room")
                println(error)
                self.setRoomOffline("living_room")
            } else if httpResponse.statusCode == 200 {
                println("Living Room is online")
                self.setRoomOnline("living_room")
            } else {
                println("Something isn't right in the living room")
                println(response)
                println(data)
                self.setRoomOffline("living_room")
            }
        })
        dataTask.resume()
    }
    
    func setBedRoomStatus() {
        var url = NSURL(string: "\(config.baseUrl)/bed_room/monitor")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            if error != nil {
                println("An error occured while loading the bed room")
                println(error)
                self.setRoomOffline("bedroom")
            } else if httpResponse.statusCode == 200 {
                println("Bedroom is online")
                self.setRoomOnline("bedroom")
            } else {
                println("Something isn't right in the bed room")
                println(response)
                println(data)
                self.setRoomOffline("bedroom")
            }
        })
        dataTask.resume()
    }
    
    func setRoomOnline(room: String) {
    }
    
    func setRoomOffline(room: String) {
    }

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
    
    func sendRemoteSignal(remote: String, code: String) {
        var url = NSURL(string: "\(config.baseUrl)/send/\(remote)/\(code)")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            if error != nil {
                println("An error occured while sending \(code) to \(remote)")
                println(error)
            } else {
                println(response)
                println(data)
            }
        })
        dataTask.resume()
    }

}

