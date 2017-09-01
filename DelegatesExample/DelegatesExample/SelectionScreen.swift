//
//  SelectionScreen.swift
//  DelegatesExample
//
//  Created by Machiel van Dorst on 28-08-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// This is the "Boss" view, it determins what and how to do it.

// The blueprint on what the delegate (Intern, BaseScreen.swift) should do with the info
// that's passed to it. How should it handle it?
protocol SideSelectionDelegate {
    func didTapChoice(image: UIImage, name: String, color: UIColor)
}

class SelectionScreen: UIViewController {
    
    // This is actually an instance of the "intern". Which can be used to give it some orders. 
    // The BaseScreen (intern) will set itself as a delegate of SelectionScreen (boss) 
    var selectionDelegate: SideSelectionDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // You can force unwrap the images since we know we have them! Don't do this with network images!
    @IBAction func rebelButtonTapped(_ sender: UIButton) {
        selectionDelegate.didTapChoice(image: UIImage(named: "vader")!, name: "Darth Vader", color: .red)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        selectionDelegate.didTapChoice(image: UIImage(named: "luke")!, name: "Luke Skywalker", color: .cyan)
        dismiss(animated: true, completion: nil)
    }

}
