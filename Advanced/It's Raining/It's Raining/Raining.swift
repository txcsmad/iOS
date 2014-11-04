//
//  Raining.swift
//  It's Raining
//
//  Created by Brad Zeis on 10/30/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

import Foundation
import SpriteKit

//// Node Generation
func cloud(frame: CGRect) -> SKNode {
    // Load Texture
    let imageName = "cloud\(arc4random_uniform(2))"
    let cloud = SKSpriteNode(imageNamed: imageName)
    
    cloud.position = frame.randPoint
    
    // Set up shader
    // This will load the file "cloud.fsh" and use
    // the program while rendering the clouds
    let shader = SKShader(fileNamed: "cloud")
    cloud.shader = shader
    
    // Inject Actions
    velocity(CGVector(dx: randRange(-2, 2), dy: 0), cloud)
    wrap(frame, cloud)
    
    return cloud
}

func clouds(frame: CGRect, n: Int) -> SKNode
{
    let clouds = SKNode()
    
    for i in 0..<n {
        clouds.addChild(cloud(frame))
    }
    
    return clouds
}

//// Node Actions
// Notice how each of these functions have an input SKNode
// and return an SKNode. We'll explore the implications
// of this in the next class
func forever(action: SKAction, node: SKNode) -> SKNode {
    node.runAction(SKAction.repeatActionForever(action))
    return node;
}

func velocity(vel: CGVector, node: SKNode) -> SKNode {
    return forever(SKAction.moveBy(vel, duration: 1/30), node)
}

func wrap(frame: CGRect, node: SKNode) -> SKNode {
    
    let action = SKAction.customActionWithDuration(1/60) {
        (node: SKNode!, elapsedTime: CGFloat) in
        
        if node.position.x < frame.minX {
            // Left of frame, moving left
            node.position.x = frame.maxX
        } else if node.position.x > frame.maxX {
            // Right of frame, moving right
            node.position.x = frame.minX
        }
    }
    
    return forever(action, node)
}
