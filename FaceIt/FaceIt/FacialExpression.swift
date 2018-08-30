//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Machiel van Dorst on 13-10-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import Foundation

// Model of the facial expression.
struct FacialExpression {
    
    // Cases for the eyes (int auto assigns rawvalues) 
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    // Cases for the mouth, including ways to make it sadder and happier.
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
    
        // recursive computed far, which return 1 sadder case than the current.
        // if no lower rawValue can be set, it's already the saddest. Set it to frown.
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        // Same for happy
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    // The actual eyes and mouth constants, which can be set for an instance of FacialExpression.
    // Constant, because if you want to change the mouth, you assign the computed sadder/happier
    // variables, 
    let eyes: Eyes
    let mouth: Mouth
    // Computed vars that reteurn a new FE with the same eyes, but sadder/happier mouth.
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
}














