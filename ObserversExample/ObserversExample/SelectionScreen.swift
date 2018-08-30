//
//  SelectionScreen.swift
//  DelegatesExample
//
//  Created by Machiel van Dorst on 28-08-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// This is a sender of noticiations. Send different ones dependent on what button is pressed.

class SelectionScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // So define a name for a noticiation (rawvalue of an enum). Use the global notification strings
    // defined in the observer (or globals.swift). Seperate constant for redability.
    // Then post that using default.post. Send the name, and object = nil since no objects need
    // to be passed here. Just the notification needs to go out
    // Finally, dismiss this view.
    @IBAction func rebelButtonTapped(_ sender: UIButton) {
        let name = Notification.Name(rawValue: lightNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // So again, you post a notification which the name lightNotificationKey define in other file. 
    // You have observers listening for a notification with that name. 
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        let name = Notification.Name(rawValue: darkNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true, completion: nil)
    }

}
