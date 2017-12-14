//
//  GetHelpMessageViewController.swift
//  iNotify
//
//  Created by Meseret  Kebede on 29/11/2017.
//  Copyright © 2017 Team Erica. All rights reserved.
//
import Foundation
import UIKit
import Contacts
import ContactsUI

class GetHelpMessageViewController: UIViewController, CNContactPickerDelegate, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var getHelpName: UITextField!
    @IBOutlet weak var getHelpContact: UITextField!
    @IBOutlet weak var getHelpMessage: UITextView!
    
    var preSetNickname = ""
    var preSetContact = ""
    var preSetMessage = ""
    
    // Edit logic of keyboard
    // For UITextView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //Make 'Done/Return' button close keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    // For UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    /**
     Request access to user's contacts and call openContacts to select message recipient
     */
    @IBAction func contacts(_ sender: Any) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
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
    
    /**
     Helper function to pop up list of user's phone contacts to select a message recipient
     */
    func openContacts(){
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true){
            
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        
        var phoneNumbers = [String]()
        if contact.isKeyAvailable(CNContactPhoneNumbersKey) {
            for phoneNumber in contact.phoneNumbers {
                
                let phone = phoneNumber.value
                phoneNumbers.append(phone.stringValue)
            }
        }
        
        
        if getHelpContact.text!.isEmpty{
            getHelpContact.text = phoneNumbers[0] //currently just appending first phone number
        }
        else{
            getHelpContact.text = getHelpContact.text! + "; "
            getHelpContact.text = getHelpContact.text! + phoneNumbers[0]
        }
        
    }
    
    /**
     Save the Get Help instance inputted by the user
     */
    @IBAction func getHelpSaveMessage(_ sender: Any) {
        appSettings.addGetHelpRecipient(Name: getHelpName.text!, Contact: getHelpContact.text!, Message: getHelpMessage.text)
        _  = self.navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     Delete a Get Help instance previously inputted by the user
     */
    @IBAction func getHelpDeleteMessage(_ sender: Any) {
        appSettings.deleteGetHelpRecipient(Name: preSetNickname)
        _  = self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make the UITextView delegate this ViewController so we can modify keyboard behavior
        getHelpMessage.delegate = self
        getHelpName.delegate = self
        getHelpContact.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        getHelpName.text = preSetNickname
        getHelpContact.text = preSetContact
        getHelpMessage.text = preSetMessage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Add Text Message"
    }
    
}
