//
//  FaceView.swift
//  FaceIt
//
//  Created by Machiel van Dorst on 15-09-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// This app to learn about drawing in a view. Draw a face.
// Remember to set to redraw in IB to redraw when orientation changes.
class FaceView: UIView {
    
    // MARK: Properties
    // CGFloat to scale shape down a bit. Public, let others change it. 
    var scale: CGFloat = 0.9
    
    // Skull dimensions relative to the bounds. Make them computed, so when the bounds change,
    // they do as well. Relate all other drawings to this for correct scaling. 
    
    // Set the draw radius to smallest of width and height (orentation changes). Scale it down
    // to fit better in the view. Set the center of the skull to the mid coors or the bounds
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    // Enum for the eyes
    private enum Eye {
        case left
        case right
    }
    // Ratios for the face dimensions. Use a struct with static vars, because they're constants
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    // MARK: Drawing methods
    // Return a path to use in the draw method. Each defines a path, a path width and returns that.
    
    // Skull:
    // Set the path to a UIBezierPath. Use the arc parameter, and just go all the way around for circle
    // Angle 0 is straight to the right, is in radians. The start and end angle need to be CGFloat, 
    // can't be a simple int and double. Also set width of line
    private func pathforSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    // Eyes:
    // Use the Ratios and skullRadius/Center to calc path for each eye.
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        // Define eyeCenter for left and right. Calc the offset from the ratios, and use
        // them to correct the center to proper location. Return it. 
        // NOTE: in the y direction, - is up! The 0, 0 is in the top-left corner. 
        // NOTE: in the x direction, either offset the eye to the left (*-1) or to the right (*1)
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += (eye == .left ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        // Define a Radius of the eye using the Ratios, and use method to define center, 
        // based on what eye case is based to outer method.
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    override func draw(_ rect: CGRect) {
        // MARK: Draw the skull
        UIColor.blue.set()
        pathforSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
    }
}



















