//
//  TimerData.swift
//  SRMPracticeTimer
//
//  Created by Mohd Asif on 23/08/14.
//  Copyright (c) 2014 Asif. All rights reserved.
//

import Foundation
import CoreData

class TimerData: NSManagedObject {

    @NSManaged var problemName: String
    @NSManaged var division: String
    @NSManaged var language: String
    @NSManaged var dateEntered: NSDate
    @NSManaged var timerValue: String
}
