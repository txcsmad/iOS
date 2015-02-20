//
//  BallView.swift
//  LessonTwo
//
//  Created by Michael Brennan on 2/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class BallView: UIImageView {

    var velocityX: CGFloat
    var velocityY: CGFloat
    
    init(image: UIImage!, velocityX: CGFloat, velocityY: CGFloat) {
        self.velocityX = velocityX
        self.velocityY = velocityY
        super.init(image: image)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(deltaTime: CGFloat) {
        center = CGPoint(x: center.x + velocityX * deltaTime, y: center.y + velocityY * deltaTime)
    }

}
