//
//  GameScene.swift
//  It's Raining
//
//  Created by Brad Zeis on 10/28/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        // Make some clouds within cloudsFrame
        // Make all clouds children of a single SKNode,
        // then reposition the parent to move the entire group
        let cloudsFrame = CGRect(center: CGPointZero,
            size: CGSize(width: 800, height: 30))
        
        let storm = clouds(cloudsFrame, 35)
        storm.position.x = frame.midX
        storm.position.y = frame.height - 30
        addChild(storm)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
