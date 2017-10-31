//
//  ViewController.swift
//  FaceIt
//
//  Created by Machiel van Dorst on 15-09-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // The face view. This is a conncection to the view from the controller. 
    @IBOutlet weak var faceView: FaceView!
    // The model of facialexpression, defined in FacialExpression.swift. connection from
    // controller to model.
    var expression = FacialExpression(eyes: .open, mouth: .grin)
    
}

