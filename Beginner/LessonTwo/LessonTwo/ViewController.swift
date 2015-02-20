//
//  ViewController.swift
//  LessonTwo
//
//  Created by Michael Brennan on 2/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let paddle = BlockView(image: UIImage(named: "paddle.png"), velocityX: 0, velocityY: 0)
    let ball = BallView(image: UIImage(named: "ball.png"), velocityX: 0, velocityY: 0)
    var upperBoundary = CGRectZero
    var leftBoundary = CGRectZero
    var rightBoundary = CGRectZero
    var lowerBoundary = CGRectZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {

        paddle.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddle.frame))
        paddle.userInteractionEnabled = true
        view.addSubview(paddle)
        let movePaddle = UIPanGestureRecognizer(target: self, action: "didMovePaddle:")
        paddle.addGestureRecognizer(movePaddle)
        
        
        ball.center = view.center
        view.addSubview(ball)
        let frameTime = 1.0/60.0
        eventLoop(frameTime) {
            self.ball.update(CGFloat(frameTime))
            self.applyPhysics()
        }
        
        
        upperBoundary = CGRect(x: 0, y: -1, width: CGRectGetWidth(view.frame), height: 1)
        leftBoundary = CGRect(x: -1, y: 0, width: 1, height: CGRectGetHeight(view.frame))
        rightBoundary = CGRect(x: CGRectGetWidth(view.frame), y: 0, width: 1, height: CGRectGetHeight(view.frame))
        lowerBoundary = CGRect(x: 0, y: CGRectGetHeight(view.frame), width: CGRectGetWidth(view.frame), height: 1)
    }
    
    func applyPhysics() {
        if CGRectIntersectsRect(ball.frame, paddle.frame) {
            ball.velocityY = -ball.velocityY
            ball.velocityX = ball.velocityX + paddle.velocityX <= 1200 ? ball.velocityX + paddle.velocityX : 1200
        } else if CGRectIntersectsRect(ball.frame, upperBoundary) {
            ball.velocityY = -ball.velocityY
        } else if CGRectIntersectsRect(ball.frame, leftBoundary) || CGRectIntersectsRect(ball.frame, rightBoundary) {
            ball.velocityX = -ball.velocityX
        } else if CGRectIntersectsRect(ball.frame, lowerBoundary) {
            reset()
        }
    }
    
    func didMovePaddle(recognizer: UIPanGestureRecognizer) {
        if (ball.velocityX == 0 && ball.velocityY == 0) {
            ball.velocityY = 800
        }
        
        let translation = recognizer.translationInView(view)
        if let recognizerView = recognizer.view {
            paddle.velocityX = recognizer.velocityInView(view).x
            recognizerView.center = CGPoint(x: recognizerView.center.x + translation.x, y: recognizerView.center.y)
        }
        recognizer.setTranslation(CGPoint(x: 0, y: 0), inView: view)
    }
    
    func reset() {
        ball.center = view.center
        paddle.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddle.frame))
        ball.velocityY = 0
        ball.velocityX = 0
    }
    
}


func eventLoop(rate: NSTimeInterval, block: () -> ()) {
    block()
    
    let queue = dispatch_get_main_queue()
    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(rate * Double(NSEC_PER_SEC)))
    
    dispatch_after(delay, queue) {
        eventLoop(rate, block)
    }
    
    
}

