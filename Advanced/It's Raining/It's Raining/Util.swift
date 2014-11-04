//
//  Util.swift
//  It's Raining
//
//  Created by Brad Zeis on 10/30/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

import Foundation
import CoreGraphics

func randRange(lower: CGFloat, upper: CGFloat) -> CGFloat {
    let r = CGFloat(arc4random()) / CGFloat(UINT32_MAX);
    return lower + (upper - lower) * r;
}

extension CGRect {
    
    // Because SpriteKit origin is in the center of an object,
    // it's often useful to initialize a rect with a center coordinate
    init(center: CGPoint, size: CGSize)
    {
        origin = CGPointZero
        self.size = size
        
        self.center = center
    }
    
    // Seriously, why isn't this builtin?
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - width / 2
            origin.y = newValue.y - height / 2
        }
    }
    
    // Return a random point somewhere within the CGRect
    var randPoint: CGPoint {
        return CGPoint(x: randRange(minX, maxX), y: randRange(minY, maxY))
    }
}
