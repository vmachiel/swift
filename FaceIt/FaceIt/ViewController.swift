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
    // Dictionary with the model's mouth curvatures and corresponding view settings.
    private let mouthCurvatures: [FacialExpression.Mouth: Double] = [.frown: -1.0,
                                                                     .smirk: -0.5,
                                                                     .neutral: 0.0,
                                                                     .grin: 0.5,
                                                                     .smile: 1.0]
    
    // Method to update UI, makes the model match the UI. So check the model's current
    // status, update the view.
    private func updateUI() {
        // first check eyes. So for example: model.eyes open, set view to open eyes (true in this case)
        switch expression.eyes {
        case .open:
            faceView.eyesOpen = true
        case .closed:
            faceView.eyesOpen = false
        case .squinting:
            faceView.eyesOpen = false  // squinting is closed for now. Model/view won't always match 100%
        }
    }
}

















