//
//  ViewController.swift
//  Bubbles
//
//  Created by andrew Mcdonald on 3/17/15.
//  Copyright (c) 2015 Andrew McDonald. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(4800, error: nil)
        
        var myDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        
        var audioCaptureInput = AVCaptureDeviceInput(device: myDevice, error: nil)
        
        audioCaptureSession.addInput(audioCaptureInput)  // grabs audio from mic
        
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        
        audioCaptureSession.addOutput(audioDataOutput)
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        
        for channel in connection.audioChannels as [AVCaptureAudioChannel] {
            
            println("Average Power Level = \(channel.averagePowerLevel) & Peak Hold Level = \(channel.peakHoldLevel)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

