//
//  ViewController.swift
//  Breakout
//
//  Created by Michael Brennan on 2/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let paddle = BlockView(image: UIImage(named: "paddle.png"), velocityX: 0, velocityY: 0)
    let ball = BallView(image: UIImage(named: "ball.png"), velocityX: 0, velocityY: 750)
    var leftBoundary: CGRect = CGRectZero
    var rightBoundary: CGRect = CGRectZero
    var upperBoundary: CGRect = CGRectZero
    var lowerBoundary: CGRect = CGRectZero

    func blah() -> Int {
        return 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()

    }
    
    override func viewDidAppear(animated: Bool) {
        
        leftBoundary = CGRect(x: -1, y: 0, width: 1, height: CGRectGetHeight(view.frame))
        rightBoundary = CGRect(x: CGRectGetWidth(view.frame), y: 0, width: 1, height: CGRectGetHeight(view.frame))
        upperBoundary = CGRect(x: -1, y: -1, width: CGRectGetWidth(view.frame) + 2, height: 1)
        lowerBoundary = CGRect(x: 0, y: CGRectGetHeight(view.frame), width: CGRectGetWidth(view.frame), height: 1)

        
        paddle.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddle.frame))
        view.addSubview(paddle)
        paddle.userInteractionEnabled = true
        let movePaddle = UIPanGestureRecognizer(target: self, action: "didMovePaddle:")
        paddle.addGestureRecognizer(movePaddle)
        
        ball.center = view.center
        view.addSubview(ball)
        
        let blocksArray: Array = makeEnemies()
        
        periodically(0.016) {
            self.ball.update(0.016)
            self.applyPhysics()
        }
    }
    
    func makeEnemies() -> NSArray {
        let array = NSMutableArray()
        for index in 0...5 {
            let block = BlockView(image: UIImage(named: "block.png"), velocityX: 0, velocityY: 0)
            if index <= 2 {
                block.center = CGPoint(x: Int(CGRectGetWidth(block.frame)) * index, y: 0)
            } else {
                block.center = CGPoint(x: Int(Int(CGRectGetWidth(block.frame) * (index % 3))), y: CGRectGetHeight(block.frame))
            }
            array.addObject(block)
        }
        return NSArray(array: array)
    }
    
    func didMovePaddle(pan: UIPanGestureRecognizer) {
        let translation = pan.translationInView(view)
        if let panView = pan.view {
            if let center = pan.view?.center {
                paddle.velocityX = pan.velocityInView(view).x
                pan.view?.center = CGPoint(x: center.x + translation.x, y: center.y)
            }
        }
        pan.setTranslation(CGPointMake(0, 0), inView: view)
    }
    
    func applyPhysics() {
        let ballPhysicsBody = ball.frame
        
        if CGRectIntersectsRect(ballPhysicsBody, paddle.frame) || CGRectIntersectsRect(ballPhysicsBody, upperBoundary) {
            ball.velocityY = -ball.velocityY
            ball.velocityX = ball.velocityX + paddle.velocityX <= 1200 ? ball.velocityX + paddle.velocityX : 1200
        } else if CGRectIntersectsRect(ballPhysicsBody, leftBoundary) || CGRectIntersectsRect(ballPhysicsBody, rightBoundary) {
            ball.velocityX = -ball.velocityX
        } else if CGRectIntersectsRect(ballPhysicsBody, lowerBoundary) {
            reset()
        }
    }
    
    func reset() {
        paddle.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddle.frame))
        ball.center = view.center
        ball.velocityX = 0
        ball.velocityY = 750
        paddle.velocityX = 0
        paddle.velocityY = 0
    }

}

func periodically(rate: NSTimeInterval, f: () -> ()) {
    let queue = dispatch_get_main_queue()
    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(rate * Double(NSEC_PER_SEC)))
    f()
    dispatch_after(delay, queue) {
        periodically(rate, f)
    }
}

