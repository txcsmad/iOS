import Foundation
import UIKit
import AVFoundation

@objc class SoundPlayer: NSObject {
    static var engine = AVAudioEngine()
    static var beatPlayer = AVAudioPlayerNode()
    static var sampleOnePlayer = AVAudioPlayerNode()
    static var sampleTwoPlayer = AVAudioPlayerNode()
    static var sampleThreePlayer = AVAudioPlayerNode()

    static var beat = AVAudioPCMBuffer()
    static var sampleOne = AVAudioPCMBuffer()
    static var sampleTwo = AVAudioPCMBuffer()
    static var sampleThree = AVAudioPCMBuffer()

    class func setup(){
        SoundPlayer.beat = fillWithFile("beat")
        SoundPlayer.sampleOne = fillWithFile("yell")
        SoundPlayer.sampleTwo = fillWithFile("hey")
        //SoundPlayer.sampleThree = fillWithFile("digitalTriplet")
        attachAndConnectNodeToMainMixer(SoundPlayer.beatPlayer)
        attachAndConnectNodeToMainMixer(SoundPlayer.sampleOnePlayer)
        attachAndConnectNodeToMainMixer(SoundPlayer.sampleTwoPlayer)
        attachAndConnectNodeToMainMixer(SoundPlayer.sampleThreePlayer)
        SoundPlayer.engine.startAndReturnError(nil)
        SoundPlayer.beatPlayer.play()
        SoundPlayer.sampleOnePlayer.play()
        SoundPlayer.sampleThreePlayer.play()
        SoundPlayer.sampleTwoPlayer.play()

    }

    class func playBeat() {
        SoundPlayer.beatPlayer.scheduleBuffer(SoundPlayer.beat, atTime: nil, options: .Loops, completionHandler: nil)
    }

    class func playSampleOne() {
        SoundPlayer.sampleOnePlayer.scheduleBuffer(SoundPlayer.sampleOne, atTime: nil, options: .Interrupts, completionHandler: nil)
    }

    class func playSampleTwo() {
        SoundPlayer.sampleTwoPlayer.scheduleBuffer(SoundPlayer.sampleTwo, atTime: nil, options: .Interrupts, completionHandler: nil)
    }

    class func playSampleThree() {
        SoundPlayer.sampleThreePlayer.scheduleBuffer(SoundPlayer.sampleThree, atTime: nil, options: .Interrupts, completionHandler: nil)
    }

    class func fileDuration(fileName: String) -> Double{
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "wav")!)
        let audioAsset = AVURLAsset(URL:url, options:nil)
        let audioDuration = audioAsset.duration
        return Double(CMTimeGetSeconds(audioDuration))
    }
    class func getAudioFormat() -> (AVAudioFormat) {
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beat", ofType: "wav")!)
        let file = AVAudioFile(forReading: url, error: nil)
        return file.processingFormat

    }

    class private func attachAndConnectNodeToMainMixer(node: AVAudioNode) {
        SoundPlayer.engine.attachNode(node)
        SoundPlayer.engine.connect(node, to: SoundPlayer.engine.mainMixerNode, format: getAudioFormat())
    }

    class private func fillWithFile(fileName: String) -> (AVAudioPCMBuffer) {
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "wav")!)
        var file = AVAudioFile(forReading: url, error: nil)
        var buffer = AVAudioPCMBuffer(PCMFormat: file.processingFormat, frameCapacity: UInt32(file.length))
        file.readIntoBuffer(buffer, error: nil)
        return buffer
        
    }
}