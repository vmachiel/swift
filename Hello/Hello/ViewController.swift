//
//  ViewController.swift
//  Hello
//
//  Created by Machiel van Dorst on 22-03-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBAction func sayHello(_ sender: Any) {
        helloLabel.text = "Hello"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

