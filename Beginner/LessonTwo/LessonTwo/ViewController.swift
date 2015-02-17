//
//  ViewController.swift
//  LessonTwo
//
//  Created by Michael Brennan on 2/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let paddleImage = UIImage(named: "paddle.png")
        let paddleImageView = UIImageView(image: paddleImage)

        paddleImageView.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddleImageView.frame))
        paddleImageView.userInteractionEnabled = true
        view.addSubview(paddleImageView)
        
        let movePaddle = UIPanGestureRecognizer(target: self, action: "didMovePaddle:")
        paddleImageView.addGestureRecognizer(movePaddle)
        
        
        
        let ballImage = UIImage(named: "ball.png")
        let ballImageView = BallView(image: ballImage, velocityX: 0, velocityY: 100)
        ballImageView.center = view.center
        view.addSubview(ballImageView)
        let frameTime = 1.0/60.0
        eventLoop(frameTime) {
            ballImageView.update(CGFloat(frameTime))
        }
    }
    
    func didMovePaddle(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        if let recognizerView = recognizer.view {
            recognizerView.center = CGPoint(x: recognizerView.center.x + translation.x, y: recognizerView.center.y)
        }
        recognizer.setTranslation(CGPoint(x: 0, y: 0), inView: view)
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

