//
//  Settings.swift
//  iNotify
//
//  Created by William A. Rodriguez on 11/19/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit



class Settings {
    var firstTimeRunning:Bool
    
    var displayMessage:String
    var latitude:Double
    var longitude:Double
    
    var notifyScreenDict:[String:Dictionary<String, String>]
    var getHelpScreenDict:[String:Dictionary<String, String>]
    
    var mailSMTPHostName: String
    var mailUserName: String
    var mailPassword: String
    var mailDisplayName: String
    
    
    init(){
        //Check if app settings have been changed at least once
        if let x = UserDefaults.standard.object(forKey: "firstTimeRunning") as? Bool{
            self.firstTimeRunning = x
            self.displayMessage = UserDefaults.standard.object(forKey: "displayMessage") as! String
            self.latitude = UserDefaults.standard.object(forKey: "latitude") as! Double
            self.longitude = UserDefaults.standard.object(forKey: "longitude") as! Double
            self.mailSMTPHostName = UserDefaults.standard.object(forKey: "mailSMTPHostName") as! String
            self.mailUserName = UserDefaults.standard.object(forKey: "mailUserName") as! String
            self.mailPassword = UserDefaults.standard.object(forKey: "mailPassword") as! String
            self.mailDisplayName = UserDefaults.standard.object(forKey: "mailDisplayName") as! String
            
            self.notifyScreenDict = UserDefaults.standard.object(forKey: "notifyScreenDict") as![String:Dictionary<String, String>]
            self.getHelpScreenDict = UserDefaults.standard.object(forKey: "getHelpScreenDict") as![String:Dictionary<String, String>]
            
        }
        else {
            
            self.firstTimeRunning = true
            self.displayMessage = "I'm not feeling well. Could you get me some water?"
            self.latitude = 0
            self.longitude = 0
            self.mailSMTPHostName = "smtp.gmail.com"
            self.mailUserName = "jennyjin43@gmail.com"
            self.mailPassword = "newbeginnings<3"
            self.mailDisplayName = "Jenny"
            self.notifyScreenDict = [:]
            self.getHelpScreenDict = [:]
        }
    }
    
    func getNotifyScreenDict ()-> [String:Dictionary<String, String>] {
        return self.notifyScreenDict
    }
    
    func getGetHelpScreenDict ()-> [String:Dictionary<String, String>] {
        return self.getHelpScreenDict
    }
    
    func getGetHelpContactInfo (Name: String) -> [String: String]{
        return self.getHelpScreenDict[Name]!
    }
    
    func getNotifyContactInfo (Name: String) -> [String:String]{
        return self.notifyScreenDict[Name]!
    }
    
    func addGetHelpRecipient (Name: String, Contact: String, Message:String) {
        let messageContent: [String: String] = ["Name": Name, "Contact": Contact, "MessageBody": Message]
        self.getHelpScreenDict[Name] = messageContent
    }
    
    func addNotifiTextRecipient (Name: String, Contact: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Text", "Name": Name, "Contact": Contact, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    func addNotifiEmailRecipient (Name: String, toContact: String, Subject: String, Message: String) {
        let messageContent: [String: String] = ["Type": "Email", "Name": Name, "To": toContact, "Subject": Subject, "MessageBody": Message]
        self.notifyScreenDict[Name] = messageContent
    }
    
    func updateLatitude(newLatitude:Double){
        self.latitude = newLatitude
    }
    
    func updateLongitude(newLongitude:Double){
        self.longitude = newLongitude
    }
    
    func getLatitude()->Double{
        return self.latitude
    }
    
    func getLongitude()->Double{
        return self.longitude
    }
    
    func updateDisplayMessage(newMessage:String){
        self.displayMessage = newMessage
    }
    
    func getDisplayMessage()->String{
        return self.displayMessage
    }
    
    func getMailSettings()->[String:String] {
        return ["mailSMTPHostName":self.mailSMTPHostName,"mailDisplayName":self.mailDisplayName,"mailUserName":self.mailUserName, "mailPassword":self.mailPassword]

        }
    }



