//
//  ViewController.swift
//  Breaker-4-9
//
//  Created by Michael Brennan on 10/28/14.
//  Copyright (c) 2014 Breaker-4-9. All rights reserved.
//

import UIKit
import AVFoundation
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, AVAudioRecorderDelegate {
    
    @IBAction func touchingButton(sender: AnyObject) {
        if let browser = browserViewController {
            if !recorder.recording {
                recorder.prepareToRecord()
                
                recorder.record()
                println("Recording now!!!")
            }
        } else {
            browserViewController = MCBrowserViewController(serviceType: serviceType, session: session)
            browserViewController.delegate = self
            
            self.presentViewController(browserViewController, animated: false, completion: nil)
        }
    }
    
    @IBAction func finishedTouchingButton(sender: AnyObject) {
        if recorder.recording {
            recorder.stop()
            
            var error = NSErrorPointer()
            let data = NSData(contentsOfFile: outputFileURL!.path!)
            session.sendData(data, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: error)
            println("Send Data Error: \(error)")
        }
    }
    
    
    
    var browserViewController: MCBrowserViewController!
    var session: MCSession!
    var assistant: MCAdvertiserAssistant!
    var peerID: MCPeerID!
    let serviceType = "Walkie-Talkie"
    
    var recorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    var outputFileURL: NSURL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Sweet Audio Stuff
        var error = NSErrorPointer()
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: error)
        println("Audio Session Error: \(error)")
        
        let pathComponents = NSArray(objects:
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!,
            ["MyAudioMemo.m4a"].last!
        )
        outputFileURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        let recordSettings = [AVFormatIDKey : kAudioFormatMPEG4AAC, AVSampleRateKey : 44100.0, AVNumberOfChannelsKey : 2]
        
        recorder = AVAudioRecorder(URL: outputFileURL, settings: recordSettings, error: error)
        println("Recorder Setup Error: \(error)")
        
        
        // Creates Peer ID and Session
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        session = MCSession(peer: peerID)
        session.delegate = self
        
        // Creates advertiser and hands in session
        assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)
        assistant.start()
    }

    
    //    MARK: -- Browser VC Delegate Methods --

    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //    MARK: -- Session Delegate Methods --
    
    // Recieved data from remote peer
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        var error = NSErrorPointer()
        player = AVAudioPlayer(data: data, error: error)
        player.play()
        println("AVAudioPlayer Setup Error: \(error)")
    }
    
    
    
    
    // UNUSED DELEGATE METHODS!
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }

}

