//
//  ViewController.swift
//  DelegatesExample
//
//  Created by Machiel van Dorst on 28-08-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// This is the "Intern" view: it gets told what to do.

class BaseScreen: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = chooseButton.frame.size.height / 2   // round corners
    }

    @IBAction func chooseButton(_ sender: UIButton) {
        // When the button is passed, set up the SelectionVC
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        // This says: the selectionVC(Boss) has a variable called selectionDelegate (Which follows a protocol). Set
        // "me" (the intern, this VC, self) as that delegate.
        selectionVC.selectionDelegate = self
        // Now the selectionVC (Boss) gets presented, and has this VC set as it's delegate
        present(selectionVC, animated: true, completion: nil)
        
    }
}

// Put your conforming to the protocol in a seperate extention for clearity. 
extension BaseScreen: SideSelectionDelegate {
    
    func didTapChoice(image: UIImage, name: String, color: UIColor) {
        mainImageView.image = image
        nameLabel.text = name
        view.backgroundColor = color
    }
}


















