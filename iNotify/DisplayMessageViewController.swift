//
//  DisplayMessageViewController.swift
//  iNotify
//
//  Created by William A. Rodriguez on 10/29/17.
//  Copyright © 2017 Team Erica. All rights reserved.
//

import UIKit

class DisplayMessageViewController: UIViewController {
    
    
    @IBOutlet weak var displayMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from appSettings
        appSettings.addAnalyticsTrackerDisplay()
        displayMessageLabel.text =  appSettings.getDisplayMessage()
        displayMessageLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

        
        // logic to prevent the screen from going to sleep when in display mode
        let secondsinOneMinute:Int = 60
        UIApplication.shared.isIdleTimerDisabled = true // Stop screen from going to sleep
        let desiredMinutesBeforeSleep:Int = 20
        let when = DispatchTime.now() +  .seconds(secondsinOneMinute*desiredMinutesBeforeSleep) // change 2 to desired number of seconds
        print("Will wait \(desiredMinutesBeforeSleep) minutes before re-enabling sleep")

        DispatchQueue.main.asyncAfter(deadline: when) {
            UIApplication.shared.isIdleTimerDisabled = false // Re-enable screen to go to sleep
        }
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Display"
    }

}
