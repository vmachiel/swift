//
//  FaceView.swift
//  FaceIt
//
//  Created by Machiel van Dorst on 15-09-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

// This app to learn about drawing in a view. Draw a face.
// Remember to set to redraw!
class FaceView: UIView {

    // CGFloat to scale shape down a bit
    var scale: CGFloat = 0.9
    override func draw(_ rect: CGRect) {
        // Draw the skull
        // Set the draw radius to smallest of width and height (orentation changes). Scale it down 
        // to fit better in the view
        let skullRadius = min(bounds.size.width, bounds.size.height) / 2 * scale
        // Set the center of the skull to the mid coors or the bounds
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        // Set the path to a UIBezierPath. Use the arc, and just go all the way around for circle
        // Angle 0 is straight to the right, is in radians.
        // The start and end angle need to be CGFloat, can't be a simple int and double.
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        // Set widht of the line and color, and call stroke to draw the line
        path.lineWidth = 5.0
        UIColor.blue.set()
        path.stroke()
    }
}
