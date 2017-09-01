//
//  SelectionScreen.swift
//  DelegatesExample
//
//  Created by Machiel van Dorst on 28-08-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class SelectionScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func rebelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
