//
//  FirstViewController.swift
//  Home Remote
//
//  Created by James Hulley on 5/26/15.
//  Copyright (c) 2015 James Hulley. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var offlineOverlay: UIView!
    
    struct Config {
        let baseUrl: String
        var roomOnline: Bool
        var room: String
    }

    var config = Config(baseUrl: "http://10.0.1.54:3000", roomOnline: false, room: "living_room")
    //var config = Config(baseUrl: "http://127.0.0.1:3000", roomOnline: false, room: "living_room")
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getRoomStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getRoomStatus() {
        var url = NSURL(string: "\(config.baseUrl)/\(config.room)/monitor")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            if error != nil {
                self.setRoomStatus(false)
                println("An error occured while loading the \(self.config.room)")
                println(error)
            } else {
                let httpResponse = response as! NSHTTPURLResponse
                if httpResponse.statusCode == 200 {
                    self.setRoomStatus(true)
                } else {
                    self.setRoomStatus(false)
                    println(response)
                }
            }
        })
        dataTask.resume()
    }
    
    func setRoomStatus(status: Bool) {
        config.roomOnline = status
        if status {
            self.offlineOverlay.hidden = true
            println("\(config.room) is online")
        } else {
            self.offlineOverlay.hidden = false
            println("\(config.room) is offline")
        }
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
    
    @IBAction func refreshStatusPressed(sender: AnyObject) {
        getRoomStatus()
        //self.offlineOverlay.hidden = true
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
            }
        })
        
        if config.roomOnline {
            dataTask.resume()
        } else {
            println("Cannot send \(code) to \(remote) because \(config.room) is offline")
        }
    }

}

