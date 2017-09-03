//
//  ViewController.swift
//  DelegatesExample
//
//  Created by Machiel van Dorst on 28-08-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// THIS IS THE OBSERVER, Which can listen to many different notification senders. 

// The keys for the different notification. The observer (Base) can react to each differently.
// You declare these globally. Normally, create a constants file to declare global variables. This ex. is simple
// They have to be unique, use your bundleID to achieve that (not necessary, good practice though)
let lightNotificationKey = "com.vmachiel.lightSide"
let darkNotificationKey = "com.vmachiel.darkSide"
// Note that it's best practice to remove observers when they are no longer necessary. Do this in this case
// when the BaseScreen is de-allocated.

class BaseScreen: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Create variables to reference each notification object. You also set these in the SelectionScreen to
    // be sent
    let light = Notification.Name(rawValue: lightNotificationKey)
    let dark = Notification.Name(rawValue: darkNotificationKey)
    
    // Remove the observer when the screen is deinited. This is best practice, otherwise you'll have 
    // obserers all over the place in big projects, listening when it's not necessary.
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = chooseButton.frame.size.height / 2   // round corners
        createObservers()
    }
    
    // Create the observers in seperate function. This method sets them up, and is called from viewDidLoad()
    // Some are redundant, but their purpose here is to demo Observers
    func createObservers() {
        
        // light side observers
        // So add observers. So the init with 4 arguments: 1: what is the observer? In this case, this view is
        // so self. This is the object "registering as an observer"
        // 2: selector: what method is called when the notification is received.
        // 3: name: what obsever to respond to. This name is send from the SelectionScreen.
        // 4: What object to pass to the selector, nil in this case.
        
        // #selector is an obje style selector that selects another method to use. Read more about that.
        // I THINK: you simply select a method to use and
        // you pass it nothing, the name is passed via 3rd parameter.. it looks like.
        
        // So now you have three observers setup that listen for a notification to be posted with the name
        // com.vmachiel.lightSide (defined globally). And three for dark side. Each triggers a method that is 
        // selected by the #selector, and passes the name or the posted notification, and passes no object (nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateCharacterImage(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateNameLabel(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateBackground(notification:)), name: light, object: nil)
        //Dark side observers.
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateCharacterImage(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateNameLabel(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateBackground(notification:)), name: dark, object: nil)
    }
    
    // The methods that get called when the observer (self) gets the messages (notifications)
    // Each one checks if the name is light, and sets the image/name/background to light side, OR dark
    // and sets everything  
    func updateCharacterImage(notification: NSNotification) {
        
        let isLight = notification.name == light
        let image = isLight ? UIImage(named: "luke")! : UIImage(named: "vader")!
        mainImageView.image = image
    }
    
    func updateNameLabel(notification: NSNotification) {
        
        let isLight = notification.name == light
        let name = isLight ? "Luke Skywalker" : "Darth Vader"
        nameLabel.text = name
    }
    
    func updateBackground(notification: NSNotification) {
        
        let isLight = notification.name == light
        let color = isLight ? UIColor.cyan : UIColor.red
        view.backgroundColor = color
    }

    @IBAction func chooseButton(_ sender: UIButton) {
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        present(selectionVC, animated: true, completion: nil)
        
    }
}


























