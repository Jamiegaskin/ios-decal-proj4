//
//  ViewController.swift
//  Synthesize Me
//
//  Created by Jamie Gaskin on 5/1/16.
//  Copyright © 2016 Jamie Gaskin. All rights reserved.
//  Code adapted from https://swiftios8dev.wordpress.com/2015/03/05/sound-effects-using-avaudioengine/
//  and http://www.techotopia.com/index.php/Recording_Audio_on_iOS_8_with_AVAudioRecorder_in_Swift

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioRecorder: AVAudioRecorder?
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var G: UIButton!
    @IBOutlet weak var Gs: UIButton!
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var As: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var Cs: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var Ds: UIButton!
    @IBOutlet weak var E: UIButton!
    @IBOutlet weak var F: UIButton!
    var sampleRecorded: Bool?
    let a = 1.059463094359
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sampleRecorded = false
        audioEngine = AVAudioEngine()
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        let soundFilePath = docsDir + "sound.caf"
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("audioSession error:")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings as! [String : AnyObject])
        } catch {
            print("audioSession error:")
        }
        audioRecorder?.prepareToRecord()
        
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            audioRecorder?.record()
            recordButton.selected = true
        } else {
            audioRecorder?.stop()
            recordButton.selected = false
            sampleRecorded = true
            do {
                try audioFile = AVAudioFile(forReading: (audioRecorder?.url)!)
            } catch {
                print("error recording")
            }
        }
    }
    
    func playAudio(pitch: Int) {
        if audioRecorder?.recording == false && sampleRecorded == true {
            let audioPlayerNode = AVAudioPlayerNode()
            
            audioPlayerNode.stop()
            audioEngine.stop()
            audioEngine.reset()
            
            audioEngine.attachNode(audioPlayerNode)
            
            let changeAudioUnitTime = AVAudioUnitTimePitch()
            changeAudioUnitTime.pitch = Float(pitch)
            audioEngine.attachNode(changeAudioUnitTime)
            audioEngine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
            audioEngine.connect(changeAudioUnitTime, to: audioEngine.outputNode, format: nil)
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            do {
                try audioEngine.start()
            } catch {
                print("error playing")
            }
            
            audioPlayerNode.play()
            
        }
    }
    @IBAction func playG(sender: AnyObject) {
        playAudio(-500)
    }
    @IBAction func playGs(sender: AnyObject) {
        playAudio(-400)
    }
    @IBAction func playA(sender: AnyObject) {
        playAudio(-300)
    }
    @IBAction func playAs(sender: AnyObject) {
        playAudio(-200)
    }
    @IBAction func playB(sender: AnyObject) {
        playAudio(-100)
    }
    @IBAction func playC(sender: AnyObject) {
        playAudio(0)
    }
    @IBAction func playCs(sender: AnyObject) {
        playAudio(100)
    }
    @IBAction func playD(sender: AnyObject) {
        playAudio(200)
    }
    @IBAction func playDs(sender: AnyObject) {
        playAudio(300)
    }
    @IBAction func playE(sender: AnyObject) {
        playAudio(400)
    }
    @IBAction func playF(sender: AnyObject) {
        playAudio(500)
    }
    
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

