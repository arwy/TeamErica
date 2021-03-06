//
//  TextNotifyEditController.swift
//  iNotify
//
//  Created by Meenakshi on 21/11/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import ContactsUI

class TextNotifyEditController: UIViewController, CNContactPickerDelegate, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var recipients: UITextField!
    @IBOutlet weak var notifyMessage: UITextView!
    @IBOutlet weak var notifyGroupName: UITextField!
        
    var preSetRecipients = ""
    var preSetMessage = ""
    var preSetGroupName = ""
    
    @IBAction func notifyAddText(_ sender: Any) {
        appSettings.addNotifiTextRecipient(Name: notifyGroupName.text!, Contact: recipients.text!, Message: notifyMessage.text)
        _  = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func notifyDeleteMessage(_ sender: Any) {
        appSettings.deleteNotifyRecipient(Name: preSetGroupName)
        _  = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // Built-in documentation
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
  
    /// Closes that keyboard for a text view
    ///
    /// - Parameters:
    ///   - textField: To close the keyboard for text view on pressing the Done/Return button
    ///   - string: Here, this is the Return button
    /// - Returns: Closes the keyboard by setting bool false
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make the UITextView delegate this ViewController so we can modify keyboard behavior
        notifyMessage.delegate = self
        recipients.delegate = self
        notifyGroupName.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        recipients.text = preSetRecipients
        notifyMessage.text = preSetMessage
        notifyGroupName.text = preSetGroupName
        
        notifyMessage.delegate = self //make notifyMessage use this file's 'return' text
        print("Inside")
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Add Text Message"
    }
    
    
    /// Accesses the saved contacts from the phone
    ///
    /// - Parameter sender: UIButton that called this function
    @IBAction func contacts(_ sender: Any) {

        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType) //Asks for permission to access contacts
        
        if authStatus == CNAuthorizationStatus.notDetermined{
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: {(success,nil) in
                if success {
                    self.openContacts()
                }
                    
                else {
                    print("Not Authorised!")
                }
            })
        }
        else if authStatus == CNAuthorizationStatus.authorized{
            self.openContacts()
        }
    }
    
    /// Function that opens the contacts from the user's phone
    func openContacts(){
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    /// Called when user does not pick any contact and presses cancel
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true){
            
        }
    }
    
    // built-in documentation
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        
        var phoneNumbers = [String]()
        //Access the phone number of the contact and assign it to variable
        if contact.isKeyAvailable(CNContactPhoneNumbersKey) {
            for phoneNumber in contact.phoneNumbers {
                
                let phone = phoneNumber.value
                phoneNumbers.append(phone.stringValue)
            }
        }
        
        //Make the UI look good when displaying the numbers
        if recipients.text!.isEmpty{
            recipients.text = phoneNumbers[0] //currently just appending first phone number
        }
        else{
            recipients.text = recipients.text! + "; "
            recipients.text = recipients.text! + phoneNumbers[0]
        }
        
        
    }
    
}
