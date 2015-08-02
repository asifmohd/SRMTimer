//
//  FormViewController.swift
//  SRMPracticeTimer
//
//  Created by Mohd Asif on 20/08/14.
//  Copyright (c) 2014 Asif. All rights reserved.
//

import UIKit
import CoreData

class FormViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var problemNameTextField: UITextField!
    @IBOutlet weak var divisionControl: UISegmentedControl!
    @IBOutlet weak var languageTextField: UITextField!
    
    // Constants and variables
    var timerValue: String?
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func saveData(sender: UIButton) {
        if (self.languageTextField.text != "" && self.problemNameTextField.text != "") {
            self.createTimerData()
            self.navigationController!.popViewControllerAnimated(true)
        }
        else {
            UIAlertView(title: "Fields are empty" , message: "One or more fields are empty. Please fill them and then click Save", delegate: nil, cancelButtonTitle: "OK").show()
            NSLog("Fields are empty");
        }
    }
    
    // Create and saves a new TimerData Object into CoreData using value from textFields and segmentedControl
    func createTimerData() {
        let entityDescription = NSEntityDescription.entityForName("TimerData", inManagedObjectContext: managedObjectContext!)
        let timerData = TimerData(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        timerData.timerValue = self.timerValue!
        timerData.dateEntered = NSDate()
        timerData.language = self.languageTextField.text
        timerData.division = self.divisionControl.titleForSegmentAtIndex(self.divisionControl.selectedSegmentIndex)!
        timerData.problemName = self.problemNameTextField.text
        self.managedObjectContext?.save(nil)
    }
    
    // MARK: - UITextFieldDelegate methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.returnKeyType == UIReturnKeyType.Next) {
            self.languageTextField.becomeFirstResponder()
        }
        
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == self.languageTextField && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            self.animateTextField(textField, up: true);
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == self.languageTextField && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            self.animateTextField(textField, up: false);
        }
    }
    
    // Animate languageTextField to be visible when user edits it in landscape mode
    func animateTextField(textField: UITextField, up: Bool)
    {
        let movementDistance = 100
        let movementDuration = 0.3
        var movement = movementDistance
        if up {
            movement = -movementDistance
        }
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, CGFloat(movement));
        UIView.commitAnimations()
    }
}
