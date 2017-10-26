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
}
