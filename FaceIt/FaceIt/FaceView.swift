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
// @IBDesignable makes it so that you can see and inspect it in interface builder
@IBDesignable
class FaceView: UIView {
    
    // MARK: Properties
    // Make them IBInspectable to use in IB. TYPE THEM, IB can't infer like Swift can. 
    // CGFloat to scale shape down a bit. Public, let others change it.
    @IBInspectable
    var scale: CGFloat = 0.9
    
    // Are the eyes open? Again, public
    @IBInspectable
    var eyesOpen: Bool = true
    
    // Smilling or frowning? 1.0 = full smile, -1.0 is frown.
    @IBInspectable
    var mouthCurvature: Double = 1.0
    
    // Linewidth to use.
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    // Color to draw in
    @IBInspectable
    var color: UIColor = UIColor.blue
    
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
        path.lineWidth = lineWidth
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
        
        // If eyes open, path is basic circle like skull. 
        // If not, move to the middle in y direction (center of eye) and the edge of the x direction
        // which is the left most point of the eye "circle". Draw a line to the right point
        let path: UIBezierPath  // NOTE: Not inited, even though it's let, can be inited by either if or else
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        
        path.lineWidth = lineWidth
        return path
    }
    // Mouth: use Beziercurve with control points to bend the smils. use the mouthCurvature to
    // control how much
    private func pathForMouth() -> UIBezierPath {
        // Again, use the Ratios to calculate demensions and offsets
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        // Rect where the mouth is gonna be, used to build actual smile. Will no be drawn,
        // used as guid.
        let mouthRectangle = CGRect(x: skullCenter.x - mouthWidth / 2,
                                    y: skullCenter.y + mouthOffset / 2,
                                    width: mouthWidth, height: mouthHeight)
        
        // Off set of the smile/frown. Restrict to -1, 1 using min and max.
        let smileOffset: CGFloat = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRectangle.height
        // Start of the mouth is to the left in the middle, end to the right in middle
        let start = CGPoint(x: mouthRectangle.minX, y: mouthRectangle.midY)
        let end = CGPoint(x: mouthRectangle.maxX, y: mouthRectangle.midY)
        
        // Use control points to guide the smile. 2 are used, both are 1/3 of the way from the left
        // and right edge, and in y use the offset: 1.0 is full smile. Remember: down is + in y direction
        let cp1 = CGPoint(x: start.x + mouthRectangle.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRectangle.width / 3, y: start.y + smileOffset)
        
        // Create path, and draw smile.
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        // MARK: Draw the skull
        color.set()
        pathforSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
}



















