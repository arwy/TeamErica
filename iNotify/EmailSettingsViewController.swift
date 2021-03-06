//
//  EmailSettingsViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 12/2/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class EmailSettingsViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var emailDisplayName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var emailPassword: UITextField!
    @IBOutlet var emailSMTPserver: UITextField!
    @IBOutlet weak var currentEmailLabel: UILabel!
    
    // hides text fields keyboard upon 'Return/Done'
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    /**
     Checks if email inputted is valid
     Retrieved from https://stackoverflow.com/questions/24842834/swift-good-coding-practice-if-statement-with-optional-type-bool

     @param: email String
     @return: boolean if email is valid
     */
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /**
     Checks if URL exists
     Retrived from https://stackoverflow.com/questions/28079123/how-to-check-validity-of-url-in-swift
 
     @param: URL String
     @return: boolean if there is a URL
     */
    func isValidUrl (urlString: String?) -> Bool {
        
        if (urlString?.count)! > 0{ //just checks non-empty, should switch to proper regex
            return true
        } else {
            return false
        }
    }
    
    /**
     Saves the email settings that are inputted
     */
    @IBAction func saveEmailSettings(_ sender: Any) {
        //Check if email is valid
        if !isValidEmail(testStr: self.emailAddress.text!) {
            // Confirm box
            let alert = UIAlertController(title: "Invalid email", message: "Please enter a valid email address", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                return

            }))
            
            present(alert, animated: true, completion: nil)
            
        }
        //Check if server URL is valid
        if !isValidUrl(urlString: self.emailSMTPserver.text!) {
            // Confirm box
            let alert = UIAlertController(title: "Invalid SMTP Host Name", message: "Please enter a valid SMTP Host Name URL", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                return
                
            }))
            present(alert, animated: true, completion: nil)
            
        }
        
        
        // gets the preset values from email settings
        let newDisplayName:String = self.emailDisplayName.text!
        let newMailUserName:String = self.emailAddress.text!
        let newMailPassword:String = self.emailPassword.text!
        let newMailSMTPHostName:String = self.emailSMTPserver.text!
        
        let bodyMessage:String = "Changing sending email address to \"\(newDisplayName)\" (\(newMailUserName)) \n through this outgoing email server: \(newMailSMTPHostName)"
        
        // confirms if user wants to update these settings
        let refreshAlert = UIAlertController(title: "Updating Email Settings", message: bodyMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // if user says yes update the settings
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            appSettings.updateMailDisplayName(newDisplayName:newDisplayName )
            appSettings.updateMailUserName(newEmail: newMailUserName )
            appSettings.updateMailPassword(newPassword: newMailPassword)
            appSettings.updateMailSMTPHostName(newSMTPAddress: newMailSMTPHostName)
            
            //Return to root View Controller afterwards
            _  = self.navigationController?.popToRootViewController(animated: true)
        }))
        
        // if user presses cancel then dont do anything
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Pre-populate fields with current settings
        currentEmailLabel.text = "\(appSettings.mailDisplayName) (\(appSettings.mailUserName))"
        emailDisplayName.text = appSettings.mailDisplayName
        emailAddress.text = appSettings.mailUserName
        emailSMTPserver.text = appSettings.mailSMTPHostName
        emailDisplayName.delegate = self
        emailAddress.delegate = self
        emailPassword.delegate = self
        emailSMTPserver.delegate = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Edit Email Settings"
    }
}
