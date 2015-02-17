//
//  ViewController.swift
//  Breakout
//
//  Created by Michael Brennan on 2/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()

    }
    
    override func viewDidAppear(animated: Bool) {
        
        let paddleImage = UIImage(named: "paddle.png")
        let paddleView: UIImageView = UIImageView(image: paddleImage)
        
        paddleView.center = CGPoint(x: view.center.x, y: CGRectGetHeight(view.frame) - CGRectGetHeight(paddleView.frame))
        view.addSubview(paddleView)

        paddleView.userInteractionEnabled = true
        let movePaddle = UIPanGestureRecognizer(target: self, action: "didMovePaddle:")
        paddleView.addGestureRecognizer(movePaddle)
        
        let ballImage = UIImage(named: "ball.png")
        let ballView = BallView(image: ballImage, velocityX: 0, velocityY: 10)
        ballView.center = view.center
        view.addSubview(ballView)
        periodically(0.016) {
            ballView.update(0.016)
        }
    }
    
    func didMovePaddle(pan: UIPanGestureRecognizer) {
        let translation = pan.translationInView(view)
        if let panView = pan.view {
            if let center = pan.view?.center {
                pan.view?.center = CGPoint(x: center.x + translation.x, y: center.y)
            }
        }
        pan.setTranslation(CGPointMake(0, 0), inView: view)
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

