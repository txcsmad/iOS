//
//  ViewController.swift
//  Mixer
//
//  Created by Nick Walker on 4/20/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var sampleOne: UIButton!
    @IBOutlet weak var sampleTwo: UIButton!
    @IBOutlet weak var sampleThree: UIButton!
    @IBOutlet weak var sampleFour: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        SoundPlayer.setup()
        SoundPlayer.playBeat()

    }

    override func viewDidAppear(animated: Bool) {
        startProgress()
    }

    func startProgress(){
        progressBar.backgroundColor = UIColor.blueColor()
        UIView.animateWithDuration(SoundPlayer.fileDuration("beat"), animations: {self.progressBar.backgroundColor = UIColor.redColor()}) { value in
            self.startProgress()
        }

    }
    @IBAction func buttonOnePressed(sender: AnyObject) {
        SoundPlayer.playSampleOne()
    }
    @IBAction func buttonTwoPressed(sender: AnyObject) {
        SoundPlayer.playSampleTwo()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

