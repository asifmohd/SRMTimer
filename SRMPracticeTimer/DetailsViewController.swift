//
//  DetailsViewController.swift
//  SRMPracticeTimer
//
//  Created by Mohd Asif on 23/08/14.
//  Copyright (c) 2014 Asif. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // Outlets
    @IBOutlet weak var problemNameLabel: UILabel!
    @IBOutlet weak var timeTakenLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // The object passed by HistoryTableViewController, which is used for initialising the labels from the outlets above
    var timerDataObject: TimerData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.problemNameLabel.text = self.timerDataObject?.problemName
        self.timeTakenLabel.text = self.timerDataObject?.timerValue
        self.divisionLabel.text = self.timerDataObject?.division
        self.languageLabel.text = self.timerDataObject?.language
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        let date = self.timerDataObject?.dateEntered
        self.dateLabel.text = formatter.stringFromDate(date!)
    }
}
