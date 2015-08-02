//
//  ViewController.swift
//  SRMPracticeTimer
//
//  Created by Mohd Asif on 20/08/14.
//  Copyright (c) 2014 Asif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var milliSeconds = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    var milliSecondsString = "00"
    var secondsString = "00"
    var minutesString = "00"
    var hoursString = "00"
    var paused = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "increaseTimerCount", userInfo: nil, repeats: true);
    }

    // The function which is called by the timer every millisecond
    func increaseTimerCount() {
        if !self.paused {
            milliSeconds++;
            if milliSeconds == 100 {
                milliSeconds = 0
                seconds++;
            }
            if seconds == 60 {
                seconds = 0
                minutes++
            }
            if minutes == 60 {
                minutes = 0
                hours++
            }
            if hours == 24 {
                hours = 0
            }
        }
        if hours < 10 {
            self.hoursString = "0\(self.hours)"
        }
        else {
            self.hoursString = "\(self.hours)"
        }
        
        if minutes < 10 {
            self.minutesString = "0\(self.minutes)"
        }
        else {
            self.minutesString = "\(self.minutes)"
        }
        
        if seconds < 10 {
            self.secondsString = "0\(self.seconds)"
        }
        else {
            self.secondsString = "\(self.seconds)"
        }
        
        if milliSeconds < 10 {
            self.milliSecondsString = "0\(self.milliSeconds)"
        }
        else {
            self.milliSecondsString = "\(self.milliSeconds)"
        }
        self.timerLabel.text = "\(self.hoursString):\(self.minutesString):\(self.secondsString):\(self.milliSecondsString)"
    }
    
    // MARK: - IBActions
    
    @IBAction func startTimer(sender: UIButton) {
        if startButton.titleLabel!.text == "Start" {
            self.startButton .setTitle("Stop", forState: UIControlState.Normal)
            self.startButton.titleLabel!.text = "Stop"
            self.paused = false
            self.saveButton.enabled = true;
        }
        else {
            self.startButton .setTitle("Start", forState: UIControlState.Normal)
            self.paused = true
        }
    }
    
    @IBAction func resetTimer(sender: UIButton) {
        milliSeconds = 0
        seconds = 0
        minutes = 0
        hours = 0
        paused = true
        self.saveButton.enabled = false;
        if (self.startButton.titleLabel!.text == "Stop") {
            self.startButton .setTitle("Start", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func saveTimer(sender: UIButton) {
        if (self.startButton.titleLabel!.text == "Stop") {
            self.startButton.setTitle("Start", forState: UIControlState.Normal)
            self.paused = true;
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(FormViewController)) {
            var fvc = segue.destinationViewController as! FormViewController
            fvc.timerValue = "\(self.hoursString):\(self.minutesString):\(self.secondsString):\(self.milliSecondsString)"
        }
    }
    
}

